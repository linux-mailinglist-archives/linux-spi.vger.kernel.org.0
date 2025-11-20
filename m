Return-Path: <linux-spi+bounces-11440-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB78C76599
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 22:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F0D034FBDE
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 21:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E2030AD15;
	Thu, 20 Nov 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="VSqwrmj3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A163054CE
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673230; cv=none; b=KjRf/6HFZ0Ia+Ab6+bZKs2+vISqCequKfdlcxciO85tlBW/HAC2hpXDXme1iySOLW7IVtEoZKuw8ngg7FVnrSJOjB3XPfhPQFA/rova42bb52obCWJB8Stt6o16hBaMqqWEnDeZxOb8H5X/Bl2Wg5Zb2kdqZZpGxh4eaP4GW4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673230; c=relaxed/simple;
	bh=/QBHhu5/mf5VqkoFrsU7ZBKAZLJ0DAd9JGOgESKJEj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLhtDSQnRL8WoZ3ouYCSRLCjc1SXux13trCHxi4cAbHCmJF1tO861WNvqCrg6FuQFIm1CU53L1D2oU4gBKyKdkHE02str5qO/m5VjCP3PWjwmZEHv6j2hdNKzsiz1R/i6s7D0EoXuJ92TYJD1JntvZO+vjTBpFBniGOjSCjfJPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=VSqwrmj3; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b29ff9d18cso130335785a.3
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1763673228; x=1764278028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKI5rd+bNks7evkZ2sb5RD79CIhkTakhfZrmrMaIYvc=;
        b=VSqwrmj3U6kuX6Lxhl4OVVv6+R9iqunUDz9euDYO3DbVzivYR/MAdgWSNOrzMhTHd9
         LZRnWnVCIyqTGsvHHza/xdIZEcvVq7AiOPDg52qZWOtw3urzEhGWeUl6R2P9fY3SAaZM
         /lS5b/vQLFBTKY1FniDMUNx9RLN171LlDUrdsnRtqhiYcdgOZzcBa7rCDp9hn/uljZkp
         O7uv+MX5IVrYfWRXwNsYmyCrcVW1HHohKeJFhsqcvBodJQztQTdASbYMWsMImiJxPi0d
         wVwiQJ8MEEl96P+Kfj6StCyLdNT3BaEYIt+f45nwBXuffMeOpOymmF+axXmwhtiTuk+R
         Gw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673228; x=1764278028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKI5rd+bNks7evkZ2sb5RD79CIhkTakhfZrmrMaIYvc=;
        b=sFiUGfgAxXR1zXiKVzCkaZlCmUVEeIu7C8CEetfxvtlT1g+OHKIzxr/eL1I6j+GOaW
         82rpds84OfEzVHG8sSMVBp8MLdx3CThSc9P4C/SL1xrmJWWsM3MzUupvsIz3anExPJ1W
         ZuNWnAT4uG5dHeDdHkj0C9kXhlDyFA8LsnW2uKqq3/JO2X/WPvExu3C/cpdcoDp4mov0
         s7lpNYdZCDhFF5tdl2dZ7FrUvlWESK3a6RoBb+imeBIdaD2/lDYktjCI+LkyKhJ0ofnn
         lwSEisV7GGhSPQw12raiZJhrYMNbjamLm4V1y6Ob5eNIhkB2cdxbVIrQjzXtBdYe8j90
         n+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXoG2/yUcT9yOxDrFTbN28P7x459bsti08SRFtIhTWI4bWUrwhBWsh/0AEu1cXHi5CF7D9VswuPD6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2POWCf9Ph7ZsEqYfmRTj0zQO52coH+NCLI3NK9s0d9SyCqUP3
	lRkok5CYrFYxWT9q4/slvD5Fu4AqKix1VrierW1UqZ2Z6qkEND2Lg7/cakN9hJqqFk8=
X-Gm-Gg: ASbGncu8EGzfMuzoN79zEjaEx0vKvlKK/HgI8eMQ1dkTScdsfmsmdidQ3REN4xIco2R
	UqV9c42pb2bISHRfb02gfplZBVgtv099qP9FDZTpxIelBrXWdZID6vWoma+yFWX+WBNSvYbhXS3
	FB5FAA0m3xVpfD83NKyNXdaDZDJjjkEMAejY63M2LMDyPU2zlS19DcE13LRsIFnWMEC3hYQME/l
	0sxcK98anOtqvFbQLmHpOLw35aIrNLO8tFIfYWPuW+3q6+3pANK4qZhEdJxSe6PZubkHCn+ThEL
	L3YIwbQdA+IT0Q+4GPSp3Gmdq4uZL+O5A9CNNbM6fZlZzvmiAXBE3O1B/4f1GqIAWTKbuDwa4sg
	8Dm3ZvcpKayHzOPY0mIR+2ODWQqdSBowujA2IXcvCYft3gwrJ1AaOmspaGzPrfSl5eSzdrzxH1K
	4d/8rcB2X1kc2piTfPcVS/9wcQcFAcXEAjo+MLmVrld3kuI2FWHwAuv6D+3uxh/pvSeg==
X-Google-Smtp-Source: AGHT+IGvwgDIhs39jzthQlsKnE3PoNiaSD7wWyoE+gOYX6zCfolKtDiYjS30zyf3wqexvj4RjVflig==
X-Received: by 2002:a05:620a:29d6:b0:865:916b:2751 with SMTP id af79cd13be357-8b3385e943emr162330185a.14.1763673227980;
        Thu, 20 Nov 2025 13:13:47 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32953735dsm225958685a.24.2025.11.20.13.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:13:47 -0800 (PST)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] spi-geni-qcom: initialize mode related registers to 0
Date: Thu, 20 Nov 2025 16:12:01 -0500
Message-ID: <20251120211204.24078-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120211204.24078-1-jonathan@marek.ca>
References: <20251120211204.24078-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_fifo_params assumes these will be zero, it won't write these
registers if the initial mode is zero.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/spi/spi-geni-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 575b112d4acb1..53229150b86b5 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -675,6 +675,12 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	case 0:
 		mas->cur_xfer_mode = GENI_SE_FIFO;
 		geni_se_select_mode(se, GENI_SE_FIFO);
+		/* setup_fifo_params assumes that these registers start with a zero value */
+		writel(0, se->base + SE_SPI_LOOPBACK);
+		writel(0, se->base + SE_SPI_DEMUX_SEL);
+		writel(0, se->base + SE_SPI_CPHA);
+		writel(0, se->base + SE_SPI_CPOL);
+		writel(0, se->base + SE_SPI_DEMUX_OUTPUT_INV);
 		ret = 0;
 		break;
 	}
-- 
2.51.0


