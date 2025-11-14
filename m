Return-Path: <linux-spi+bounces-11207-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95CC5D134
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 13:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08A03B7F91
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5995231A7F4;
	Fri, 14 Nov 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="KK8inn+c"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC23164B4
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122753; cv=none; b=lIlq2fjSiJuB9kzRdbonhrF/IQampyBYA2fj4hlbMmxgv4tEq3Ep4bwjsMCN86mrhBcEYydsmRzGcedx887qiFQn/NZ76Zf7gI7Gee7gbr8ePBmtVdaiC3C1R2gNHKne47KMBPdHWukDS50zZYlYGW9nrId12MmLaYyoOOL7nQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122753; c=relaxed/simple;
	bh=OHRpJMagiKLaTMEhh9T2V0GoMorBCrqfEatgArmrqLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlVxoKXiycCI9Lcqsc6QNMVttAgFG9xsQr1qlMDK7KppggylkdyX3ohsbiaz/xRW6G9TKQuPvHN+Wwn4DIKiDQCwKnhtRCqxZxb2QVijxcfGNZnyuol74gZjYqRS6RkJIWlALqIjbzI2Z+T+NC9AjYcnCvZhcfUrg+AWl06CjPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=KK8inn+c; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so2734286a12.2
        for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 04:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1763122749; x=1763727549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJAU1WR1mzyYUMLxIXnsBVjAE6a2+g/KdU+qx5lmqJ4=;
        b=KK8inn+cBTDXDNbhI8i1xm2ddfsd3u8PJONVg8GnWZ0T4o8PsXxyshIjjpIVlPNpc1
         ajxjtQKNRhRy1+ovOHtvIPeG1uC2vN6lIv0NsYmzdbPgWw+PoWNBTqpMoRK8jaCULbrn
         LvUe2BXNqF72Q9olRqAMbdyV9OHCtVaJSMCUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122749; x=1763727549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJAU1WR1mzyYUMLxIXnsBVjAE6a2+g/KdU+qx5lmqJ4=;
        b=da9JknctmmLWS5eYpKGF8Z2VJ/yp9A4Hyg+75LW+9K+fkG5zH9KB0rdLaq5zl6NaTf
         uu6zxIxWVdMWCTOwml0BnmSOgdUGnDV2fe/bGfTejNqz5a/StQrpElUHC6jy3mIFOFIP
         1csVAqKae6JW4qUXhUpW6PlTTWcSFLsbxH8c/etAaI1BLiY70Ut7qjcTXThkBN8DxAhN
         ATYiyge4Zd4DJgA25oSPRHOf65zmyy63T7hj01Jw4fOCkhYkSE0vjYs8St3VgQqiorT4
         ybnJW0W/AsQ7iQx3YL9+q6uwBl9Atd4x8VUoEmZ0pM+xVHlIkIFUA69dpvZsfK1oCwwT
         9xYg==
X-Forwarded-Encrypted: i=1; AJvYcCVnxbHxr3kVkBojn924hy9srIdqsknr77mSDXDWZEt/JDtqor/fK8alXGzHIb6ku06GdqSG+NiMlsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPRhKUUBohmsxe7JRQ7cfNcEy+6J2xSka/nJ8+CvlJIybzYKa
	C1gtK3FLQfj6OXdXs2wWrYAeLL9D7tlGlDv30LSiwqDpLpHSYJkKo/PQqKJS/kyCXyc=
X-Gm-Gg: ASbGncvUjwrdCKuyO3IHEGHEFPFXCJuvCSGrUbEBYvZv45vW5j2sRaKbr8VLLmqtBXa
	XNuT722q/Gjh51R/WRR0MZDWIgrarOqQp4Ho1S70vJXA/vCrLU1q7FxyqDjQjzgiN5194NDqv+z
	TLRTQsgl8QVGcZQZ2EPMEUCgK6nn/rPoIJoflNjsMTdbnj+mmxvb5d0LzXGpQBE0ZGmtAC51aJY
	gKiRLHoOusTOL+NH2Z/hk5/pVOITurIIBhx/r2sw1W9qOi/E8ljkrCGqeEHoJtqcyRRl+7ki79f
	GUBlp3pOrm5EsZOMHwkzhsOgFyXMjbE+6v50IYcoXSjs6LibaAYUA/wYxVbIBQxEZ7pOzRURkUy
	U/e8hsI+PYGiiojJsEYD2EVxk6Z+FSFR8dA+OTpRDkmsK6y//C0Uyr/ypMN6Kx2j6BK/3Cq7m2D
	rIPVoJH6j86CK4tNnEuP9uhzT2nt5HgsarKLrUAsxL182ZDvdoaZfeJFHRJDTaBaTzo1pBPw==
X-Google-Smtp-Source: AGHT+IFwJoL1U/KjpDTc6Zxhp8ozUFTmTEzhEqtM8HTL6bjv53lGvy4oC0WSkiZ8azgAxX4XjtE4fA==
X-Received: by 2002:a17:906:fe41:b0:b73:2b08:ac85 with SMTP id a640c23a62f3a-b736780b8d2mr274231766b.19.1763122748989;
        Fri, 14 Nov 2025 04:19:08 -0800 (PST)
Received: from riccardo-work.fritz.box (host-82-52-164-74.retail.telecomitalia.it. [82.52.164.74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed6315sm375295666b.64.2025.11.14.04.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:19:08 -0800 (PST)
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
	m.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH v2 3/6] spi: spidev: add compatible for arduino spi mcu interface
Date: Fri, 14 Nov 2025 13:18:50 +0100
Message-ID: <20251114121853.16472-4-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114121853.16472-1-r.mereu@arduino.cc>
References: <20251114121853.16472-1-r.mereu@arduino.cc>
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
index 5300c942a2a4..9a0160f6dc3d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -704,6 +704,7 @@ static const struct class spidev_class = {
  */
 static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = /* abb */ "spi-sensor" },
+	{ .name = /* arduino */ "unoq-mcu" },
 	{ .name = /* cisco */ "spi-petra" },
 	{ .name = /* dh */ "dhcom-board" },
 	{ .name = /* elgin */ "jg10309-01" },
@@ -737,6 +738,7 @@ static int spidev_of_check(struct device *dev)
 
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "abb,spi-sensor", .data = &spidev_of_check },
+	{ .compatible = "arduino,unoq-mcu", .data = &spidev_of_check },
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
 	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
-- 
2.51.2


