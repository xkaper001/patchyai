import { NextRequest, NextResponse } from "next/server";

const KESTRA_WEBHOOK_URL = process.env.KESTRA_WEBHOOK_URL;

export async function POST(request: NextRequest) {
    try {
        if (!KESTRA_WEBHOOK_URL) {
            return NextResponse.json(
                { success: false, error: "Webhook URL not configured" },
                { status: 500 }
            );
        }

        const body = await request.json();

        const response = await fetch(KESTRA_WEBHOOK_URL, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                installation_id: body.installation_id,
                api_key: body.api_key,
            }),
        });

        if (response.ok) {
            const data = await response.text();
            return NextResponse.json({ success: true, data });
        } else {
            const error = await response.text();
            return NextResponse.json(
                { success: false, error },
                { status: response.status }
            );
        }
    } catch (error) {
        return NextResponse.json(
            { success: false, error: String(error) },
            { status: 500 }
        );
    }
}
