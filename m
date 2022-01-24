Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCA1497D37
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jan 2022 11:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiAXKdX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jan 2022 05:33:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52472 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiAXKdX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jan 2022 05:33:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCF39612DA;
        Mon, 24 Jan 2022 10:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA3C340E1;
        Mon, 24 Jan 2022 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643020402;
        bh=ZDpY32bf3JRg/e5KevpUlzOgP1yoitkBK5SwPkIgfuU=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=buKebxZmE+b0j5nd7P6irbxaH7Ch1p/vnXDys/cKf3S/1IsAbuUZpouHHX17bfuGz
         LWRO3krfbtyBqQD9PDuOYt4aCJgfFG0neE5HTElKpxjDfJuDtpT67fxTdX10m7/6f4
         2tmH6iig5sqJ8DesVpitGa657qjzXOqbU7jzspoOctppr/yX2uvFrNtdGaKjs/wziG
         PYLBeW8Q41ZNxSkJ20AbXTf+KXUqn1N/EnxxXAwlxmeBZF7QfRYqYbGSKY/rDisZet
         gx0O33uEZR0cILsVimPkKsmYGTF1wFLMGSs3b1e4FaaZuwUxqUMqj2ZmEaKUYjwMfv
         kkF+tvf/HK1zQ==
References: <20220115023135.234667-1-dmanti@microsoft.com>
 <20220115023135.234667-4-dmanti@microsoft.com>
User-agent: mu4e 1.6.10; emacs 28.0.90
From:   Felipe Balbi <balbi@kernel.org>
To:     Dmitry Antipov <daantipov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Dmitry Antipov <dmanti@microsoft.com>
Subject: Re: [PATCH v3 3/5] Documentation: DT bindings for HID over SPI.
Date:   Mon, 24 Jan 2022 12:32:39 +0200
In-reply-to: <20220115023135.234667-4-dmanti@microsoft.com>
Message-ID: <87v8y9779v.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Dmitry Antipov <daantipov@gmail.com> writes:

> From: Dmitry Antipov <dmanti@microsoft.com>
>
> Added documentation describes the required properties for implementing
> Device Tree for a device supporting HID over SPI and also provides an
> example.
>
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> ---
>  .../bindings/input/hid-over-spi.txt           | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/input/hid-over-spi.txt
>
> diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.txt b/Documentation/devicetree/bindings/input/hid-over-spi.txt
> new file mode 100755
> index 000000000000..5eba95b5724e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/hid-over-spi.txt
> @@ -0,0 +1,43 @@
> +* HID over SPI Device-Tree bindings
> +

Some windows-style line endings leaked here. Perhaps run dos2unix on the file?

-- 
balbi
