Return-Path: <linux-spi+bounces-7258-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0FA6ACF0
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB92165F3C
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603EF226173;
	Thu, 20 Mar 2025 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT2xM0mp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54341DED4B;
	Thu, 20 Mar 2025 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494341; cv=none; b=hZZwcdjm4CLOlRM1b01MabJwEOY0gGipOFc4Pv3jfbuQEIbFyUnNKDdFj1ZZ8Zzn2J8Yg0udJbpBbn8hzuVWFSlWm1dLKnSc5MBn4QeKZAU6N0qJ9LNXckRGFYjE146qtwNzFFp9NrFzmCvnhyHfGHgw8UxY7zQj5upNXHqXTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494341; c=relaxed/simple;
	bh=nvjPdX71LGd7inkaVZszmyMyYxdINYEkosCxlU1kpvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kN1HHDNUWyXOT62flNSu28rrayOX+4ZrdUAyRBzcuw0XMyYzmpOBVDZSicaKfR/uqjPmYSJ5JNfKZ3VeeAwlq3QCAXaI2cCzCUNO5NVdqWcx0yavrZYy5qKwX6UIAVEXvjY8kXjisoG9z9jyoroVuQD5XKwkJF2S5z4WrrPXU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT2xM0mp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948021a45so9478935e9.1;
        Thu, 20 Mar 2025 11:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742494338; x=1743099138; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAj8w99nfg2slGXPfJ5zVyi4hbC1dv2j2JscG9r1JDg=;
        b=nT2xM0mpKI2nHl5DsOknORFGkuxHYYps4MTSHAnyoHLV9TcbY9Xe82D291odPKqswo
         66CrgyxJCsAob5q2uKDJYtnY39w87TqEtlHF2uCNExFAL1iKOuG2bwS0hCEDalQM4+ul
         HPoalkz6Qd40aUx4tuNH3A8+PsPfDCD899iP96f//topntbbfSBnFxzM/pGorTWoRkTs
         Rz5vLiStrZ9si9IGGdcbTd8dj/GAFJt3L4199W7QTSh9zcixdQKS/tK03oLEAGoQ3Iqg
         mS6SeMmU9ctKgnyfJduq5KhZiMSinU855n35GfezGo+LC8261Ncko9G4/sxGvlfQNzyV
         OuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742494338; x=1743099138;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAj8w99nfg2slGXPfJ5zVyi4hbC1dv2j2JscG9r1JDg=;
        b=GqhQ59JbsSqRN0qac4jlmnDYQJ5Hh/IWvYkNZa/DO6hOZROk0g50NYQN9lnG1ybuw4
         bMdZPLUybFkl5lEoFq6ypInxpHJqr0cZQhOvFTPJrFenSArgOHugEid6QjlPK75obl3B
         Qm+OoXukP4cTyz54yfsnbngI5lu2fFqVndFF3lxkH3btwHy9CfADQL6yfwaqzFbqIwT0
         vbmq+x0jU/pBlQFYoPFXe8laj8Y+iof9CJdzyOfL1Dqa8H76+Rt1v0E2cdsFtg6cV3Tz
         GhyPGuC970kt8HPzr/7DyelC3OAXQKzq/9TZqiCBLHED4kNMqW0CtN/qCPgmjHD4T2wS
         CyJA==
X-Forwarded-Encrypted: i=1; AJvYcCUF+XyoVym3SaBcgfJwrWIMaZdmeL7cPBeaRXrk3/xa5RZ+IB9tAiTM7LvVpuEMkcu0EBfo8ZXs+Ig3bkZ4@vger.kernel.org, AJvYcCUVZFoJifunnYkjpVBnbmn05FLsbo9AXsMZRZmg92MUgNF6X10nKWh2hEwKaIay7s9ONCTp6HqWgvpd4qnv@vger.kernel.org, AJvYcCX+HtJRKyA28Hjj6HlCoDEQswrl3Drc0RricFMcZ7eiG3XGhrohIuVD2Kmoex7k34BXUU9H9JG1xGW2@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNhaVu/zuabCPOZRbCcSRelAd+dMJcC6eA0aI8m7+gOaADsKp
	slFU44rf7aMHt7ICt7fkB2eTkliJqgnaHnk1Nd/eEYqiXJxUBmCV
X-Gm-Gg: ASbGncsSYySAOsHmxr7oblUgHzlEPtEx1LbWEcLzWhA+HV71MIC+oxPHiyRE0ydTldK
	s8idrFQTkpl3TeyflNSPdcs1pHLGKFP3ktCL+Hl2AGZdW5Mt21X9V7/CCkMvVerjknLDko5sqng
	b1lroKurEZ9W3MXq40fU14YxecRlKTA97CoEI9Bg1sEqOgoEJek8SISEN/fjDMddlyL6+Q/Sq4F
	kSD93Z1fiIZiRPNzsNVrEVi8Wg6EQXgj2MO12NEmdCg5e9wFLCsxCBcxnzcuOaDxykfeHCB8lGl
	Ko0NRrnGbMZW37j+xfTFcSYBg9AjEGxYMBlinraMOmduEw+ixQRSrgv/lAIJjxN3xfsIoLC/URH
	Bf1Rn8jFJ
X-Google-Smtp-Source: AGHT+IFO7iQjH9/emMYq4Rm2sLpWs0UGB0cabmOue8uCKayYG0tr9zTuXMmtVUGNfuO0SoFF75D25g==
X-Received: by 2002:a5d:588b:0:b0:391:4282:f60e with SMTP id ffacd0b85a97d-3997f91d8e1mr508399f8f.32.1742494337662;
        Thu, 20 Mar 2025 11:12:17 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9e6544sm236209f8f.68.2025.03.20.11.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:12:17 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 20 Mar 2025 19:11:59 +0100
Subject: [PATCH next] spi: spi-qpic-snand: use kmalloc() for OOB buffer
 allocation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-qpic-snand-kmalloc-v1-1-94e267550675@gmail.com>
X-B4-Tracking: v=1; b=H4sIAG9a3GcC/x3MQQqDMBBA0avIrB2ICbXFq4iLdJzYoTpqIkUI3
 r3B5Vv8nyFxFE7QVRki/yTJqgVNXQF9vE6MMhaDNfZhnDW4b0KY1OuI38XP80roQktNeLf0ejo
 o4RY5yHlPe1A+Dxiu6w8mnKgFagAAAA==
X-Change-ID: 20250320-qpic-snand-kmalloc-3f6c1fb6c873
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, linux-spi@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The qcom_spi_ecc_init_ctx_pipelined() function allocates zeroed
memory for the OOB buffer, then it fills the buffer with '0xff'
bytes right after the allocation. In this case zeroing the memory
during allocation is superfluous, so use kmalloc() instead of
kzalloc() to avoid that.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index fbba7741a9bf336deed1c07eab8d5a94204878d7..b60f5c3fd1db84e66f9263404a52251460a4afec 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -261,7 +261,7 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 	ecc_cfg = kzalloc(sizeof(*ecc_cfg), GFP_KERNEL);
 	if (!ecc_cfg)
 		return -ENOMEM;
-	snandc->qspi->oob_buf = kzalloc(mtd->writesize + mtd->oobsize,
+	snandc->qspi->oob_buf = kmalloc(mtd->writesize + mtd->oobsize,
 					GFP_KERNEL);
 	if (!snandc->qspi->oob_buf) {
 		kfree(ecc_cfg);

---
base-commit: ad4488845193e81549c11903a5083b4c9cc19785
change-id: 20250320-qpic-snand-kmalloc-3f6c1fb6c873

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


