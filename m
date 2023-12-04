Return-Path: <linux-spi+bounces-140-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3234803BBA
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7632810E6
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 17:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F72E84D;
	Mon,  4 Dec 2023 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TfhmGU6l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B800CA9
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 09:35:19 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d852e06b07so1659059a34.3
        for <linux-spi@vger.kernel.org>; Mon, 04 Dec 2023 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701711319; x=1702316119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LzfPXnoh+csBX7vLMU59nOns526pWVt603zQVilgL4=;
        b=TfhmGU6lO6fg/noNszpMohBn1SHLq59i6u/ummWQ9YrTwimiP+vc11WmP1anJ7tAKl
         qS8q6JCAZhryqSnIeyd1+N/GKeoiEfbF1Stb8xx/uB0jBYAlGBOccjkd1KTDYDr3ibav
         EcN62nikiWeRCwHlfUHJE3U4xwCEx3sRGVB1ppY3bLDwifCegn0largtt0wtlPGBzd8e
         G20CFh4bwcg9/svlVG8O1q/lR2Ep7qhKEC9wCQ8swK6vZ7pamEXy9Cv3v/z3yxhF34I+
         yJli6EJ+o2JDeABeuiQzYxDJ6JQ4nmRpYHBVGxtdiXh9A/SMYeDkBPBG8Dezq1mZ+vZr
         k31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711319; x=1702316119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LzfPXnoh+csBX7vLMU59nOns526pWVt603zQVilgL4=;
        b=HecxKgzgsdQAxskW9qqTqKDj21AH3i6GFDm1ePCUU7SNcH2rDO0NwzbAMmxHyrRmIU
         BTxdKTeAMJDddFSH9rJiMag6vEAhURHf9LhI0lcB3K5WJ6n6inBIXYI8Y6JyL6U6TtDM
         U/jE7D3+8kiYAYiP+XkPNwbMtlnetp4QdT0+1/ERWh3G9qhDUV/3EDeoGq7ZeNJPUg3F
         0t1KsiiUi3Csb/7nve9WlUvKKB/koIDxeu9YZon1Zl6FgvB9zcCKD2SC80fD2V6lLtV4
         zUmPLLehKbi5IAbxRZYJlCWOE8XBWZnwQW9jKV9dMEqdnhbeURpZJcsdBF2QxVEJ9Jxi
         yUKA==
X-Gm-Message-State: AOJu0YywOR4c00Mw9gF5TEM5+sb09iQ850ICim9EUD/dmlDiZv4yF5zb
	NVaIuB+U1+IXlB6tEASk4Ri6Z8OCUy1C7NLMtvI=
X-Google-Smtp-Source: AGHT+IGtOaPvxIOHnyH/580dDNDubjZltu2MPm85XIWMx0R7RIPtoorikJI9IsraRZQp8KMwdoeMMA==
X-Received: by 2002:a9d:6e0f:0:b0:6d9:aac1:228 with SMTP id e15-20020a9d6e0f000000b006d9aac10228mr767736otr.40.1701711319036;
        Mon, 04 Dec 2023 09:35:19 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d5d10000000b006ce2fce83cbsm1956563oti.25.2023.12.04.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:35:18 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] spi: axi-spi-engine: remove delay from CS assertion
Date: Mon,  4 Dec 2023 11:33:34 -0600
Message-ID: <20231204-axi-spi-engine-series-2-v1-8-063672323fce@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
References: <20231204-axi-spi-engine-series-2-v1-0-063672323fce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Now that the AXI SPI Engine driver has support for the various CS delays
requested through struct spi_message, we don't need to add a separate
delay to the CS assertion instruction. Otherwise, we end up with longer
than requested delays.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 3798f96da586..78221715ba81 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -194,7 +194,7 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
 	if (assert)
 		mask ^= BIT(spi_get_chipselect(spi, 0));
 
-	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(1, mask));
+	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(0, mask));
 }
 
 /*

-- 
2.43.0


