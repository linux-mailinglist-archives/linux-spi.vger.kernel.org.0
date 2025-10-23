Return-Path: <linux-spi+bounces-10792-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF2C02D2B
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 20:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763E41A6816C
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2E434CFBE;
	Thu, 23 Oct 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="VeF21GZH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038534BA5E
	for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242374; cv=none; b=cwB3VEzecCKucHTfhOICiYdfLugVbtdjXtsTOvagCmt32gf3UHRkbU2dEkuljLCuBFbwkqJvnKyBvqUrcOCMa0vWv6Q0LKj+3oMjgjLznstQYn/ti5OPSRf5Ti193+0C9/+Ar16iR5ysPljWBaC+cwuDeSK1cs9J/KnjUE/A9gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242374; c=relaxed/simple;
	bh=dnCGB01wbbXE+/x5ZL+8+es/jtlarQfWqAKWcy4NrUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSpLLCzSntBqAh6ekiTHiSF+3Dqp23uG8K8/9zBIF8AOFxCiHVa+nwKg+DfzRXOs8NuxRc0GS8RKZtdnUlYv9s3PSKSp8DoOYPaD0ACE9+3quM2Lz/CG473nsYuZVLNvLJvnFDr4uoo1lyWVn1UrKDIgTqlDhcjproja6ZZ0Z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=VeF21GZH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33d7589774fso1278294a91.0
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242372; x=1761847172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LXU+r3p2H3OLM8MjqTR3TSPttnWfeamJ354G5+nCPs=;
        b=VeF21GZHrvGrqn7Ab+JECtK4KWMMiOyR05c5bP9ZAc0pe+QwmOdIMJ2ykjuL9qaYSV
         XFD1z7e0qQDy+a7ss1RwIzf9CkmffG8QtbXxzsYyus/yn/rOnZrNNCKCQ1IsHsSzOyLU
         k5RILfoqD82aU1w0pVA2Ys5HXm1Dy5Nw9oEHVqZzFajf3n96dDj0EKm+vkZnjC+rk9vM
         ToLExNrE8o4uFQIgDysKqFI60NtqOx7q7Y6ebMzLxHssDmh0nbLyIBNWuKTf7DQYzdxK
         xkC/VIbL0JvMZc2i6UQI+193gFEqjQWZ39R/mkB4T5aSNj5fNctCBdEPCVxcsSXlV4TU
         g0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242372; x=1761847172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LXU+r3p2H3OLM8MjqTR3TSPttnWfeamJ354G5+nCPs=;
        b=DFNIlETIsDnSYrdhbgyUdDxYImM9oQhEb1aq9XI3j+/ZGqiJuV5jI/5cFFW8S+lymo
         vzo5aDC2JBK1qWY13SRK8wi6RR93KMPjybTzO1lG68t3rX/10R2XF0nBjhRMa0YbeHeX
         7/yk0xV4FxUuMiDn3UibtWsWF1SpllTGfJi5RPdFbopQiXPtabj41/4sxoMPL0ehP4s4
         MgekUTxGOZ3qdK76eExouKUrod1RnFQpQ9thz0pJkytYy0cVYpMiO13G88rOHX3chXVy
         6eXnPXrtl/lly2/5vwx0yaRi5B5TqPGr9i/BR8Nx+ExG13Iv3+fSbR0el8FP9A23rNnJ
         fQtA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZDtPySuAvYt4nYvqpTLN3WA8b0WeiDW8axe4Y/A5YEvHVNy2ux7m0dvfkeHNMQX4lBW4nlUI/1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KeNhO3G4rrUPKKN1q+PI6Rpa09gyNEO28W3r/nA9ra8N422Y
	HdVyFD+HsM/x9BXUuffOVzXc/KGT07RxJ1fqso20lebMPRTC+8Q7BH1RRi53kLu1OjA=
X-Gm-Gg: ASbGnctVLy7RWiORRvRvr/VgoagW5+Au8rIAaNpukTVy48t0Ikcz17d4yQT3h36JoLL
	k5PF90PPRivcLXz9sBgvvoAdjq5pQ62F3iuc67hV5A7QaPVPFfxMdh3mJiDlcr7CR99lPsiuY8k
	Q6G9g38S5xQO+ADWvSlIbsFALsdW+UU65pUImfl2h+7JaK8c/FqOVVwRZf6mWGyFBlVCGzZ/OcL
	yXM8uuDbi/nc5cgWCrHvrhHHKPlUZjDIYrVXO8Qy/AQvy8bZ8QzAYZJgRbVk5z3iQMUUz7NrWYl
	EBQoiZ5ENxC58vIPUj4EKuMCfjB2wgF2k3YMa8L8epSxmaioV0Cwh/IglGuEyAXFaF4Ep/c03w6
	iIivCxIvqmkAiPVrytqeCP+OaHoo/jfYI6VHZwvWs37NMcuc6n3dYmBw76sr+5tUX9O8iQJaIu6
	4BZZU72AHYIkUkX8oP+kzd4Kpeat4tYx/dug==
X-Google-Smtp-Source: AGHT+IEF41yHnh/Q9tj7kOyP7EkFl0s2frDdTCHx9ucShzUXPPZ2GVIgbE/DpmewAxUbKZPk9NMitQ==
X-Received: by 2002:a17:90b:1dcb:b0:33b:b033:d7e5 with SMTP id 98e67ed59e1d1-33bcf9186f0mr36102913a91.35.1761242371953;
        Thu, 23 Oct 2025 10:59:31 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:31 -0700 (PDT)
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
Subject: [PATCH v2 6/9] spi: fsl-qspi: allot 1KB per chip
Date: Thu, 23 Oct 2025 12:59:18 -0500
Message-ID: <20251023175922.528868-7-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fsl_qspi_default_setup(), four registers define the size of blocks of
data to written to each of four chips that comprise SPI NOR flash storage.
They are currently defined to be the same as the AHB buffer size (which is
always 1KB).

The SpacemiT QSPI has an AHB buffer size of 512 bytes, but requires these
four sizes to be multiples of 1024 bytes.

Define a new field sfa_size in the fsl_qspi_devtype_data structure that, if
non-zero, will be used instead of the AHB buffer size to define the size of
these chip regions.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - New field fsl_qspi_devtype_data->sfa_size now defines the size of
       the serial flash regions if it's non-zero

 drivers/spi/spi-fsl-qspi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index c21e3804cb032..a474d1b341b6a 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -207,6 +207,7 @@ struct fsl_qspi_devtype_data {
 	unsigned int txfifo;
 	int invalid_mstrid;
 	unsigned int ahb_buf_size;
+	unsigned int sfa_size;
 	unsigned int quirks;
 	bool little_endian;
 };
@@ -737,6 +738,7 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	u32 reg, addr_offset = 0;
+	u32 size;
 	int ret;
 
 	/* disable and unprepare clock to avoid glitch pass to controller */
@@ -795,17 +797,17 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 	 * In HW there can be a maximum of four chips on two buses with
 	 * two chip selects on each bus. We use four chip selects in SW
 	 * to differentiate between the four chips.
-	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
-	 * SFB2AD accordingly.
+	 *
+	 * By default we write the AHB buffer size to each chip, but
+	 * a different size can be specified with devtype_data->sfa_size.
+	 * The SFA1AD, SFA2AD, SFB1AD, and SFB2AD registers define the
+	 * top (end) of these four regions.
 	 */
-	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
-		    base + QUADSPI_SFA1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
-		    base + QUADSPI_SFA2AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
-		    base + QUADSPI_SFB1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
-		    base + QUADSPI_SFB2AD);
+	size = q->devtype_data->sfa_size ? : q->devtype_data->ahb_buf_size;
+	qspi_writel(q, addr_offset + 1 * size, base + QUADSPI_SFA1AD);
+	qspi_writel(q, addr_offset + 2 * size, base + QUADSPI_SFA2AD);
+	qspi_writel(q, addr_offset + 3 * size, base + QUADSPI_SFB1AD);
+	qspi_writel(q, addr_offset + 4 * size, base + QUADSPI_SFB2AD);
 
 	q->selected = -1;
 
-- 
2.43.0


