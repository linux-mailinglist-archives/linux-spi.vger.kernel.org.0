Return-Path: <linux-spi+bounces-7054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58699A546A4
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 10:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCF8174251
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF4020B1EA;
	Thu,  6 Mar 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXPt/AWs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FD20AF77
	for <linux-spi@vger.kernel.org>; Thu,  6 Mar 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254010; cv=none; b=qWDzZPN6enLIWEeMaFW+Dql0guBGmub6ufsDEib30CUXcNxgbvnDU9LSGLt/93KCsJrVUH+k+hRXyiIspLoz7utkQgCJYYM1U7O/31j4emKTp2q0HP9vYC37BU4fSyEqzz74ecR9Y17PiGq6tCm0jFUTCAOgKXhg7UulaR3TRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254010; c=relaxed/simple;
	bh=E/HLOCPPolZoPIVQBIEbh+eA5DoNHzTGqfwY2lcY4Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VDM3kqx0YPnBNbcSt02U4d82B90NntdxvkdqQfAw+4D0R4C8lCeD/tbjeuQQ0vEv6PnfVr47jna0AJN1RqhCZxUUGxuekrX0ooloYmgYETRoCPI2eogbZ/S1fUxutkHh0HxOWws7ylaF245B5fhgYdazokfBf35ZNSpJFXxne7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rXPt/AWs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so3505425e9.1
        for <linux-spi@vger.kernel.org>; Thu, 06 Mar 2025 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254005; x=1741858805; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWy06ZU1rvCMAS6Oepxaxa7BjLic+0Q37gto1sXjZ9k=;
        b=rXPt/AWsMZ0Il8KwOaVhoEFc4GfGV0PlcibBlNgGO8c4PeQTmcI4FydM2T4nZuHwU0
         9yfK6GPrOXOL7NeREfkRq84YyBdkbt4Mnd6QpmUzQB5JXOAWvt2pXbz9o5GMe10R+B8t
         awnw1wtMZcLvBfml957K2H8SN9viqEMbSooyLzH4+q4hT3dzGT+eSaQ7dtzgnf6wI9FC
         H6hHvOQtsztSLIpk/Cn2Qg/cI1aBqYQ9FfBz3Fk9maxhESDNVfbeauXWzCPxQ//h9VkE
         6+YHJMQheYgzqK3G40qg4q/lhwu8Jb4vmSOJbm7vwoXD8C4lZMNmtmxVnz2NmEoV6kYt
         Pu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254005; x=1741858805;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWy06ZU1rvCMAS6Oepxaxa7BjLic+0Q37gto1sXjZ9k=;
        b=g69D1IV867u/kMtp1XQE9fbZ+wa2r2BoIFBE6mVhtrn2+sUmAOOGh5R78XM2nILfjf
         iJjx6haDzANrhjyRf+XlDNwylknitFqvI3g+9966Wpg/AOGzpMbHrtofCCfxPkZrBGcr
         kEDDtBDmWGC/ymCGBpKGT5A7KQbuAyH0ltkNCcCSHONdpsjkyfMSNi1+h5JxLdCEVWUJ
         3cryjxoz/T4HkUexAT0xL/p1fYjjabhAjLgQL/aVAfdLh8KVLBDt8JCn29a0A1QUvNKe
         tYz9gHC5MouVnvNFM7a/USHGuGixCoOf7+K16clK06ftslFXIIQntu/feJmq7sXlahyS
         f9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW82FOtOVOOo4JA+uNaTfrNmbyYsNG6Qo2ktK0s0cW8fksBu68aGBWCikH9wGbuBYEGvu+3b4fXgS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZeAnu+3rhrdIbfMSTs3MOTUboKEWKrp8VzvGDuAsp2JHgEQH
	/F2z5l/FgsCE2FAQExnvHIQrpPeJ76ck2tt+LnoqPetjNenaHGl5er0qFIFi7X4=
X-Gm-Gg: ASbGnctRt5Nz4FtvCNeE4y3Rz2ceH1MCC06Ljg/x4j6+tRuWMvNBrpgsjwwBEqCRDct
	UhzoPI87t71Pv7PQkjMzrfGq+IBOQcvAugD3rwEQvA35iAlj6Oe+IXZ5gXn2oU/cJKQEAhmRTPC
	I10dqemH4xkk1hBZ6LK7pdLD3E3fuKzViquX5tareBi6rDerA6Sufu70byrQ7IePxtxFE+2BUZr
	vcd2N/VZq9E7epQexV2LhATUyzeqOzFJCQTG+Tlk8UPfaIVbGc5BaOS/mFK0Tp0Nb0i3iTq2P3u
	JiRfQP41COK7DqkztLNPFs3zuZrNSbX8RzejyuAvLMW78jU4Yg==
X-Google-Smtp-Source: AGHT+IGuGJLNcho++arjKdFrJpv00rKH3wDvZRWW3PMXVOeUD58q0a3r8mqAyfvuFDAa6Dfhm44YnA==
X-Received: by 2002:a05:600c:3ba8:b0:43b:cd0d:944f with SMTP id 5b1f17b1804b1-43bd2945f10mr63350985e9.5.1741254005165;
        Thu, 06 Mar 2025 01:40:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd4293250sm43986635e9.16.2025.03.06.01.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:40:04 -0800 (PST)
Date: Thu, 6 Mar 2025 12:40:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: spi-qpic-snand: Fix ECC_CFG_ECC_DISABLE shift in
 qcom_spi_read_last_cw()
Message-ID: <2f4b0a0b-2c03-41c0-8a4a-3d789a83832d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ECC_CFG_ECC_DISABLE define is BIT(0).  It's supposed to be used
directly instead of used as a shifter.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 8c413a6a5152..ffb2b6ec685c 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -514,7 +514,7 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 	cfg0 = (ecc_cfg->cfg0_raw & ~(7U << CW_PER_PAGE)) |
 		0 << CW_PER_PAGE;
 	cfg1 = ecc_cfg->cfg1_raw;
-	ecc_bch_cfg = 1 << ECC_CFG_ECC_DISABLE;
+	ecc_bch_cfg = ECC_CFG_ECC_DISABLE;
 
 	snandc->regs->cmd = snandc->qspi->cmd;
 	snandc->regs->cfg0 = cpu_to_le32(cfg0);
-- 
2.47.2


