Return-Path: <linux-spi+bounces-11665-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2522EC93C04
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8008C347F54
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB42405EC;
	Sat, 29 Nov 2025 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US8FPeQ0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D019C540
	for <linux-spi@vger.kernel.org>; Sat, 29 Nov 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764412176; cv=none; b=YaVXpUecMRTiYnqKuN72qEq/wW1NTqKTzUutcFMTwIKliRn1G8uRDmQleAM8LHUoFK305eejcxZZrFICUewFjjtp3xmEHIpplz2sjpwrdJtifbwTFK1rY/nHf1Zv8umtaK6VWozN5seLTeuvud/sjXS+0Xn3rxLHnPN3Ip3GWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764412176; c=relaxed/simple;
	bh=EXIAZkX9JbCZEV40QF6tt5G/xP6fu5FJr2BYKTQr4tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pM5gagQ1l2sMp18TTcl9kSLm9kZLDnIdGnlW/6OmumWaatEqbQvxkDTSFETTPgf7NiytntFD8zCpTVPpfgnN6h1/xpdJdb9hf3rDWmKWcZ9goCSOoySKhhkpiNodgd1KCr08r2Ou3vEyq/vXFzwogTdVb4xs5hj4JwA15M5PtSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US8FPeQ0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b2dc17965so2445841f8f.3
        for <linux-spi@vger.kernel.org>; Sat, 29 Nov 2025 02:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764412172; x=1765016972; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XB8ojDLPmRPjgdbiNqqeSPVDfEQQay9vSxKvQQfS0ls=;
        b=US8FPeQ05vlOd8gQODpXBhwYuCM/mO7vzxuPEHHukdEDD2zn3/RoG6LVb+6zo8RqdH
         q3sZUUMsUR84Kf06K+K19b3MyaoOk8fvsOt+SnRrh+xhViNql1BjpXVpUBdU0CCekrlk
         qrdFIIpmYbrSjppsqiLcTWONtuKgLRNbAvmd4RIhFe3A1sLUF7ZeHWc3zVwJrFOD5ZMs
         oIb89v6lr/2+JS9k6LaO4h44PujWed+okdl6FuMZLpcl06s3VGjX++aoDUB6T8N58r8J
         TDFwj2ZW2zBJoZiJ//k5IL/ZM5Rsh8fJx9Zgk7LOzqNR7cRsKjR/4WDiNDuFlEKrUy3H
         pnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764412172; x=1765016972;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XB8ojDLPmRPjgdbiNqqeSPVDfEQQay9vSxKvQQfS0ls=;
        b=h1gZhAfY2monZStVJWK14rPDI+yzhWYhzraj3y2UOwWK7uAp2WjjYYF9okLlh9pskS
         H0pjjmU/MGMfSw7Xnde6vnD26CzBiGFoJ2S+zipdaYkRfYgx9TpmYprKR6OXjSHR7y2w
         lIC16/gS1MqibY/DCvf2iVkrX5sOg21aqJb/5GZEtkCUjuGG1Kmn0r9cP6gZwIlrbezk
         6/9zTFGwDITwnv6DMpbdh5S1vGE1nxk80ihphd8D6fysUQ5xBAzNKLHjHFBzEGRLmyOv
         gHl+6OAJ61qKOoSf9glfdC1wuEMtE6aMI2uO9LmYOpHsXCilQF0wkwr4Jmvg4WICO1YF
         NvBw==
X-Gm-Message-State: AOJu0Yw0lH42AfX5OUDMl31bCUviVb9ruBrNbQrLLods+zpxwbEyezbH
	H5282u9wKTHtLgtLlZzZ8VcuDfq5HrHJxdNUH9PJhNsWyvSJYN1VsBT/
X-Gm-Gg: ASbGncv+O9AlOz9F+hI1um4oMlI2xVkTPFYgnTs7x1zo/h7wgwGSr8fdLgQpBaPn99Q
	3mCDLr0jzCtzG30zk0oob7YYS6nIevDg6uP/KIzWZId9EYjlq9/ByipvOsff5vFilAPVPBKA+Mm
	sp9bNX+ggJ1t4o5ouyjAMFliDD/qbc9+OM8UN2xTGdLmfbvls9RYaFOdaRTxuLFLydsISJhJbmt
	8bzZBYDSNpQAZzUdkZ9eIueC4OAn7obIICuJPM1lWxII3mZwNT9HJMMp1XfNSVBr8En0lKOy5MU
	MWllwD6PWZomq81XxnnPbrhIgUuz6eOwjya5a0mD9AF0Vq1hUc74T80Iln++rOkTFGPj0/Knr4t
	VLvjjYlGz+k1fQEv6L3Jvfuoi0NdrNUKUX5PPWXiT2Y7WWjkCbXG7j2aIFMyxHQ7+xCPKKG59BA
	gu3kfN6COT4lZ4OSdxX/Nfr99yyd8LwnZQ/UdynsgdaLVoZsPIak4=
X-Google-Smtp-Source: AGHT+IFF8NfCPDZoCDRvd2e/3m3f9IuNEk2//VmqY35vg4vwN/ox68TOxm1dPHp0YHoIW6ze/wYpJw==
X-Received: by 2002:a05:6000:4026:b0:42b:2c54:d9ba with SMTP id ffacd0b85a97d-42cc1cbd449mr38035756f8f.20.1764412172508;
        Sat, 29 Nov 2025 02:29:32 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30b8sm14740128f8f.7.2025.11.29.02.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 02:29:32 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sat, 29 Nov 2025 11:29:27 +0100
Subject: [PATCH] spi: spi-qpic-snand: remove superfluous
 qcom_spi_set_read_loc() calls
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251129-qpic-snand-superfluous-readloc-v1-1-b84ca17095d9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAbLKmkC/x3NwQrCMAyA4VcZORtYy6biq4iHkGYaGG1NqAhj7
 76y43f5/w1cTMXhMWxg8lPXkjvCZQD+UH4LauqGOMY5hHjHb1VGz5QTeqtiy9pKczShtBZGvnG
 cZoojTVfokWqy6P8cPF/7fgAo3rvCcAAAAA==
X-Change-ID: 20251128-qpic-snand-superfluous-readloc-c7c245a20a46
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Before configuring the registers related to page read, both the
qcom_spi_read_page_ecc() and the qcom_spi_read_page_oob() functions
are calling qcom_spi_set_read_loc() to set the read location for the
first codeword.

However the qcom_spi_set_read_loc() function puts the passed value
into the register write cache only, from where those gets written
to the corresponding register later via DMA.

Yet, the qcom_spi_set_read_loc() is also gets called within the
internal loops, and during the first iteration the read location
register values written by the initial call gets overwritten in
the register cache.

This means that the values written by the first calls are never
getting used in practice, so remove the calls as those are
superfluous.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 7681a91d67d563fd21fcbd69d223b6e846e97787..0334ba738bef2811e3458d20ce69bd3a213cb20b 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -850,8 +850,6 @@ static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
 	snandc->regs->exec = cpu_to_le32(1);
 
-	qcom_spi_set_read_loc(snandc, 0, 0, 0, ecc_cfg->cw_data, 1);
-
 	qcom_clear_bam_transaction(snandc);
 
 	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
@@ -941,8 +939,6 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
 	snandc->regs->exec = cpu_to_le32(1);
 
-	qcom_spi_set_read_loc(snandc, 0, 0, 0, ecc_cfg->cw_data, 1);
-
 	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
 	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
 	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_clr,

---
base-commit: cb5c2eb459f4c98d584eaf3d3ea7c3612385d081
change-id: 20251128-qpic-snand-superfluous-readloc-c7c245a20a46

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


