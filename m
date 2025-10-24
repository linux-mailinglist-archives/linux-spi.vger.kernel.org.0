Return-Path: <linux-spi+bounces-10833-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371B0C07DE8
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9A4402819
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7419436C238;
	Fri, 24 Oct 2025 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="rRLK2RNN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A42727E2
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333363; cv=none; b=aUtKj8I3iymThN5Xbdhn5ZXHZbhxGfdJ+PmwQrbdmk0MoIsbhLQXntq864ta+JuctKl8/+5sr0GFxdG74RTFU3uveooPLPTBGDh7/eKN5QNyM4bvXrlUgKchmNDWINKknmj2stqWTgtyWkCbe+9XGFQLssUEQS41rElk87rLCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333363; c=relaxed/simple;
	bh=GdKb+Uk6ps8nMgwL/qeWK8J0hHUVDxnEmafXGXdT8Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bu9vKUU3sDosKlRikZ9naDREgEDCJT4PgdSSKTfRvzBTSV0Crh14NL6Oq9fx+AGJI41TiD42n7RF43lW75J7N4e792Fhp+i/mM5GIDHGtDX5J3XDl65iPsCPF6/nVVPnIGSbciCu0yfx9i+JeZa/pxHzUmK3Muy5hs1Wu07Pjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=rRLK2RNN; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-431d2ca8323so12767685ab.3
        for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333360; x=1761938160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bdm2X0Uh+6QoNIFH/yUFpeoxSayQYwUIia5PVqWIucY=;
        b=rRLK2RNNF/0qlsQJt/38SbCoilQXm6gy4bAelaxyAE+dPXVBy3kkNdNB1D+YXMngX3
         RyCEJ+hTt3Q7LjGmA2/S8ZZIZ97bi9y3EGvS2wMW6ublJzNQUixSEkR5n7nBDpmBtCXX
         Ok483E8k7fRdsl8jR3oWYp5RowGEwMSL43NkjTVzy6XwsX7Fi5ILOvCNeiOfci2KWYVL
         RgW8f6/LIZ+PjRcBlZA9p5F3CQwaiM93H2fSLiEYd4eZGCt5uYyjL0Pp5EBsbyu0CrLG
         Ua+b1W5ZGjGZBYRXBKsPVercO+wcyoFF9yy5fGESal59Oh+qvA4Cr2KCpJHu50QFo01E
         V8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333360; x=1761938160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bdm2X0Uh+6QoNIFH/yUFpeoxSayQYwUIia5PVqWIucY=;
        b=X5kOQ+vSINXne2njox21on6vuDTpXRYAVanzX/14UejaDL614T/RQUuZweLEjnHpQk
         xm2YVR0rsQGuTGvZTcR5CTT36TLwguEa+vCTmFenKPa72o/Xz4FlJ3GfG4yEN49KlSK2
         ALbbyVqX1RBw3VJlDnsEBcVy6s/u8D/S2CS5yP2eLjWTxCugasdg1ful+L1cgSrss1E2
         d30GrhRBn7bwvxxaYiBKicCwYbdyHGCFVovx3MP6YUkiOjBEsaNWurHpSJQ132zcu372
         xOrl9W4++DauWvPfWVpD6/6397khlARYMJXHCGb/9kYlGccSTNp3mclwb8WXtCq0n++6
         Skpg==
X-Forwarded-Encrypted: i=1; AJvYcCUrZB+yIEM5cu3cdKFOTyHaUI3K88MwP5KLW73UVa+yOvMbx77WuUfp0+B0RVK/nSa8pRaJhSN8xmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiz/emseh2OmWmKwnUA0TYgScp1SCioBo71IlFWAoLgaQv2U9k
	sI8/aka2H1vR0us8EYi7/4g2cI20qOLdKwi08CPdJjHYBrmEhoQOEDqgKvG7A0YkreY=
X-Gm-Gg: ASbGnctqh8/TwK5+v8ciDAjCJXtLz6Am6a54IdL3HHTmJ1dihGxLDH06GGZu0C7vZbH
	/Vo4CaQ6wnhsVKyuU33xnSMwFkT+PfY2dloR+Q2msIbJpmthSiX8Cv7Jdo13KmZGctSWj4bznSs
	HqeEih5qA4P7YF+p9dRFKxnupDJAM2yuazY7piEZnFIMIa2DngenFpLLHdjHKiOV3Eceo52qQuF
	/PvlJ3h9MUAXqeynJM7pk0MDgwxbOIdhgr7XZpzB4Ivo9T+8aTfOqCrF3xjqIvbBMb4FACbc5W5
	8BStcoFn+WhoQ7IAq7rFi0Uzas9K1n45eHVB2bZ4FsZJZrccVDwAQof+7dLZLcNjRgAthRadLaE
	O3QDoWsNjMsir6ia+eg3Hjl87BfcwMlyAg+fbBolNXOLVbZcrPdNAt3VO4Moain6G41HH9ELlQL
	3Ba0TH2EZlKswbg3nwfpdtR7P0YMJlLZIxmwNoMzaYPMg=
X-Google-Smtp-Source: AGHT+IElepsQIkPTyqRqx2ZlqiV2TkOUrhFpvX3uGDnya5yADO7YFKd2LUmYcqJ1EtE3DJar2SatmQ==
X-Received: by 2002:a05:6e02:144e:b0:42f:9353:c7bc with SMTP id e9e14a558f8ab-430c5209537mr363720175ab.6.1761333360521;
        Fri, 24 Oct 2025 12:16:00 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:16:00 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] spi: fsl-qspi: add a clock disable quirk
Date: Fri, 24 Oct 2025 14:15:45 -0500
Message-ID: <20251024191550.194946-6-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC QSPI implementation needs to avoid shutting off the
clock when changing its rate.  Add a new quirk to indicate that disabling
and enabling the clock should be skipped when changing its rate.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - needs_clk_disable() is no longer inline

 drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 1944e63169d36..2c030dd6facc7 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -197,6 +197,11 @@
  */
 #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
 
+/*
+ * Do not disable the "qspi" clock when changing its rate.
+ */
+#define QUADSPI_QUIRK_SKIP_CLK_DISABLE	BIT(6)
+
 struct fsl_qspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
@@ -306,6 +311,11 @@ static bool needs_tdh_setting(struct fsl_qspi *q)
 	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
 }
 
+static bool needs_clk_disable(struct fsl_qspi *q)
+{
+	return !(q->devtype_data->quirks & QUADSPI_QUIRK_SKIP_CLK_DISABLE);
+}
+
 /*
  * An IC bug makes it necessary to rearrange the 32-bit data.
  * Later chips, such as IMX6SLX, have fixed this bug.
@@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
 	if (needs_4x_clock(q))
 		rate *= 4;
 
-	fsl_qspi_clk_disable_unprep(q);
+	if (needs_clk_disable(q))
+		fsl_qspi_clk_disable_unprep(q);
 
 	ret = clk_set_rate(q->clk, rate);
 	if (ret)
 		return;
 
-	ret = fsl_qspi_clk_prep_enable(q);
-	if (ret)
-		return;
+	if (needs_clk_disable(q)) {
+		ret = fsl_qspi_clk_prep_enable(q);
+		if (ret)
+			return;
+	}
 
 	q->selected = spi_get_chipselect(spi, 0);
 
-- 
2.48.1


