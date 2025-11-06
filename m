Return-Path: <linux-spi+bounces-11091-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C638DC3C1A5
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 16:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF53424473
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0992A272E63;
	Thu,  6 Nov 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="AWRega6l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179929B8E5
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443091; cv=none; b=AI4mzRqPx5x3Yf7vA/GNcqC/cuRjmMJGfubR1j2fv/+UGw/ph4FWc+8Czuonf2UzA2npHZ4r3FPFVzSfeOgTdHyOjNEyZeU8DAHsdiy/j2nECEKny2C+tPEsHInrGXVFxcSSp0DjY6ysT8QI3J4+AWJc/QKNaqtcSvPXGKH6Uok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443091; c=relaxed/simple;
	bh=wPKoUnMK8vZ+AgOMszH5Qwlbo+GoY0Sp3z672Mc1Pis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0IQIBPuwWjvY+rqtfTfM/FbU9WRR7Gnn8siS22VVmKRno2SNqzAIkDgbswNavdXq7OCM9T5aI2fLDdKxRfDQ5M/W3RCIoN+1VureLCeuiP03fg+cvPY9J0qm+L3rJJg03pIl1J4G7crw4rwLmQGPQyS/HjlhksU+rC4Lug/MNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=AWRega6l; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso800248f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443085; x=1763047885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFCi2W3xPGMmw81b14h6jvOzJY80ZgmyWnBp4oBmytw=;
        b=AWRega6lZua7EDE8eQUaM+1KLjNszUt3GTyepfMoEzhKfeeKpe7XYDC5k3hJyrR4cX
         U6g5IAS6Uyb+UKp5R371PQGpknuClKf3Z8PczD+nbdT+XUhjdPmh4wbDGrD5f+9H2Wi8
         1UW1HuNqgVGAvTsu6GW0KIzQ0OTwCycr6sBgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443085; x=1763047885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFCi2W3xPGMmw81b14h6jvOzJY80ZgmyWnBp4oBmytw=;
        b=A34zEMjhMF35+ki4hp//P3d1suY6LwI4fSQ0kE+5fRbw09gOCj1tbdBDZgKy3XJjlT
         mFEyRvU5fzJ5HHSIZzusxM1Y4ciMdeDkin4NjMU/tt8D+rQJSPdRBRznGhn28/yII0CH
         x/zV031MEGVe0mS6vo6OAX43jGqbstK9hz2le9uA2SBK4Y5YHeRJqbgLXK92pUH0idIb
         knleocCvTPrOxKX8k1EnLioPB9g/PLQamj/oOBQH/z15JMApMRpMFbNoGozfkQVVYMXq
         i2ZStSA42b/Uc5NpJ/V58jRlitw05vdPcdp4SU9TJsiEhzDpbw8Fbgh7clVUZGQnI26Z
         sSoA==
X-Forwarded-Encrypted: i=1; AJvYcCUQMbrFomN8ANwzYFXf+DAldNBsiTl7gC2QcjEGKl2MZpcUH875S148VWe23M0QvxdEZQB48ztkvSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pQ2PT0qUZKGqjvs2xfXD8WNlZ7Ac96Q5W0fpQJUInVH3LCTM
	Cba0ayDVcaMk/bCRFSFuvlKbTUeq3fZcqjPaGL/w75stl63BELr73FBsg5DX7FDleaI=
X-Gm-Gg: ASbGncvbuGQ0TORkpohyy1E4WitC1Tbkj6eCuC858Fpx/9/lFhcjPEhNX2+AkjJy4Ic
	J3lN/LjSwsEVxeVUsXVQbG7K7CN/kPW5J8P5O6iMrViseLcqo+Ur/pJeAtZN11bDXRGy/p5CVys
	WwrDW40YMhLqWjL5OA1PR93fuxVGd/xyM2sUQu1nx5fOGEb+MOY9O8tBTgRQCLuPuDmn+CIiBql
	VuXIcCDpVMd64bEE8EIqWeHMREJ4uSbpFl6sxYZhdVewCRzcHB1oevB04e6XzN7kinuKFQnt7T0
	FLTX1k/qhcKhP0bZOF0cKKu0gcSCalO4RvYdtNyXai/FPbv4i9N9dwuzs5pHzWiWF5l8ePvnddw
	MUq1FLIunVbwnDAp4JXQW5cQTVbslF+gL1H3M6wfW9o+eZJLAWky9vbg12WrNPmHdaYqo/hAvmw
	nugPG5LH2N4oYCHRjqPozyMwo3F7HR0b0UcXM=
X-Google-Smtp-Source: AGHT+IGo0bYCWcjyrO5rRfbbqk+9J1qWefLXEhHHSmFWJVEVTxenM6rlhrrYWhuAbzg+tmOJeinyWg==
X-Received: by 2002:a05:6000:2002:b0:429:bfbb:5dae with SMTP id ffacd0b85a97d-429eb19d9f3mr3818004f8f.17.1762443085192;
        Thu, 06 Nov 2025 07:31:25 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:24 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
X-Google-Original-From: Riccardo Mereu <r.mereu@arduino.cc>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	mm.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH 2/5] drivers: spi: spidev: add compatible for arduino spi mcu interface
Date: Thu,  6 Nov 2025 16:31:16 +0100
Message-ID: <20251106153119.266840-3-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106153119.266840-1-r.mereu@arduino.cc>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible entry in spidev describing in Arduino boards one of the
interfaces between microprocessor and  microcontroller.

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 5300c942a2a4..f0dd516c2083 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -704,6 +704,7 @@ static const struct class spidev_class = {
  */
 static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = /* abb */ "spi-sensor" },
+	{ .name = /* arduino */ "mcu" },
 	{ .name = /* cisco */ "spi-petra" },
 	{ .name = /* dh */ "dhcom-board" },
 	{ .name = /* elgin */ "jg10309-01" },
@@ -737,6 +738,7 @@ static int spidev_of_check(struct device *dev)
 
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "abb,spi-sensor", .data = &spidev_of_check },
+	{ .compatible = "arduino,mcu", .data = &spidev_of_check },
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
 	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
-- 
2.51.2


