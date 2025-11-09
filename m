Return-Path: <linux-spi+bounces-11130-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA127C44195
	for <lists+linux-spi@lfdr.de>; Sun, 09 Nov 2025 16:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2DB3B1E30
	for <lists+linux-spi@lfdr.de>; Sun,  9 Nov 2025 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DDF2FE59A;
	Sun,  9 Nov 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mWpO+C6O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJXNhCv3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05472ECD1A
	for <linux-spi@vger.kernel.org>; Sun,  9 Nov 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762703625; cv=none; b=A2KTxMzwdw+dOjBVe7BxbT51qYP48Z+0Hn0Kn3wtLfqJ7s4utURdeoPcXwQmdbKW4dDptFt3XUGx2d7Sd62DiStxHpUr5MPnqlmolP5NsC8gcvBn1YHOaoel0vPAE88zyXZbw5xPs5EcUDS0ZVDcv2/z7m2gviKojH1KB7TjOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762703625; c=relaxed/simple;
	bh=KQnezTdDom0hsWENXoHj5Ie0hLWZqEuMHNiHb/oWtCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=guGCWTad9h0rsdBHPUWWl1QgEwPd8Z35h3Oo7nsxl0pRh5gTFRbMtgV0D15InPwReBktNj7IFfx/fec1sX3FRjdQkvn9d7uUUmnKTeJqzIhz5vSh+33cotx1tYsJr02nA1vfaihWPS6msnkUmdtSF0bNYlXv+Q2cGkL35plt2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mWpO+C6O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PJXNhCv3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A96cQsn4091819
	for <linux-spi@vger.kernel.org>; Sun, 9 Nov 2025 15:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ad5t/trqWzBhM8TQYF+OEfs7U4Sg5TTK3ZP
	9EeDm70g=; b=mWpO+C6ODxREI/Ja7/UhHiKkTn4Jtvs+lGySbj6708Uy5iEsEQ8
	+45MS1uyqyus7Pev7Dc4Q/x4NL73cqJmQCwPmQwmvjN7txYgI0Fi9FOluTWjW+k7
	OfJ1jSkiOvWpJ8+9qFQULfDusiAA5PHQ7xDRZFMI8JXOx7xfgfDHvCO1ilzvmZBy
	T75HxJ94BVtajWNS6LMrM8yxrA3YVoNjNihbP9StjmqBvsTyygJEKrrBzF9lHtcj
	2FzS7Gk61xsaSsZl+vnEUhGIgiA3pmPckU07/M01HSfwSHpAUhdUVApiUVWHZxXF
	y3tLMQpZWnbOGC4BkOtYBZq2ZufGbCsmsTA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu2taxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sun, 09 Nov 2025 15:53:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e884663b25so59625811cf.0
        for <linux-spi@vger.kernel.org>; Sun, 09 Nov 2025 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762703622; x=1763308422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ad5t/trqWzBhM8TQYF+OEfs7U4Sg5TTK3ZP9EeDm70g=;
        b=PJXNhCv3SEqoDS6dEOWS51zN7LvC0UaOGZspduZU+MKZWPGs5Huuywbo6SgvRIyKH1
         W1sFG1c+JOu9n5yZkzl6eL6XroAButfSnFTmUiknm7NN2eWAHaFeuVoNrCgr1HyFMjQp
         HZ2n7NYYBz8GAxK4KuZTb1wk+go0VpPH1GHOtleVEyVYQPQ2hkHawZPyoz+35I8eSTYn
         YR9hy9vGSAIjgasQPJsJW8hI06zQRJCtzyaYSAOQs70jBuLBaSygyOuDNCdjt0igkDUA
         tbEu/JgtC5m85Nu9P/5xfveZJuX//Xis6qWuJ3EjO79X01O0hu78nNv3WDyy6uARt2Xg
         OLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762703622; x=1763308422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad5t/trqWzBhM8TQYF+OEfs7U4Sg5TTK3ZP9EeDm70g=;
        b=fIdkUp0MbwaBk2UmnZyxn5y1rZZ4SVvHSzQHvxYNLlNlw7fhtsha+4gTl8GK/GdPkO
         Z0a55h4sOtl5nzlmB3ZlMOa5g1MmjIOqfM/NrXCRdZjMk26u5V6Lcb8UcPSmTYPL90NQ
         0g8S7sYcYd4YZTMYS6ugMvve9AEXP6Jr4EJBRaSN+Ap+zLEKdBXdSHdaVnCpmuI9cFrc
         rtApVERsR85v0LOIJwju7HteteByJcjL4QMsJ8DPXG8xcwD/x0RA8qpkDRppl9QwobBS
         CqMEeLHJXQmkhNnZiy1mTJPIGtAHar75AuHYGLfSAoCh3HBWbiPSKkeafFjJOlGM8wME
         6DaA==
X-Forwarded-Encrypted: i=1; AJvYcCUfnaJLO7/byekZH2x+c9SdS7JiAnYpAVYaFGChJCp8JAPshMqkjlEFr6YuHFQ3XCUaeFPcRMfksdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHtSsVCmxtX1pfwoy34UudHfIh1SnPFsc+Z+UQquo7HIy90xs+
	nsHj38PxRSvc1WLYnukH/YaD8NwufPHiPbR2WyTZoVhjwj2Zgj+eLctWf/+JTjB0LwnKTUaU77n
	jA29JYzcJU9yF1a/RsP8gTN04a8+ZGPP2ID7rIYogJbmN8d9ZgxZR9bGxFKCBScY=
X-Gm-Gg: ASbGncv2mzRsPWV7FFiTJLenH+wDnNp8jsdeol6sh1ttMCxCda5DfpXXAV+DvEk55aG
	BdSEjciHnoXvWdzl0o/3XjUfeUX/lQhYYWwm9bo7SRWJH4y9FRlwmzEH/tMgGOD0m09KAicz4DF
	stlFlnNw8JpLn0Qr6BS4EbXI4jmqWpxErPViO/8KmVNSQvygRnpMD5FhvSNuBRcQqhXGCbHPWN4
	w5Jm08/0sb2d4kBisgctZE8avB+wiwU5C8auxH6urPv9FzG4g3RL8D2CdsuMn5PloWq4nlRHn8u
	a+HNeAb9YyiRpmHihARoNzSG/aAeVUDNGCCUZJpMB1oa/WTarMFVmxpYof1r2tkRZ77BDOifZaI
	Yspl9n7c31eg7lK/fBk54GmgDmqqp47V+s6jWP4X9VXjjMO2qeSgFFtFMrVpAbn4KwJpT9N+D8S
	qUnhf8HdslnVreeQ==
X-Received: by 2002:ac8:598b:0:b0:4ec:f1a4:5511 with SMTP id d75a77b69052e-4eda4fc3b6amr64345051cf.65.1762703622147;
        Sun, 09 Nov 2025 07:53:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8TVYNMH9gjdSp4eih1C2sC7MPmmTtAovB2I0o9oJc5rZmDsiTsFIUZfhO6uKj8LvMxca1Jg==
X-Received: by 2002:ac8:598b:0:b0:4ec:f1a4:5511 with SMTP id d75a77b69052e-4eda4fc3b6amr64344851cf.65.1762703621703;
        Sun, 09 Nov 2025 07:53:41 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd72bsm830838366b.49.2025.11.09.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 07:53:41 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] spi: Add TODO comment about ACPI GPIO setup
Date: Sun,  9 Nov 2025 16:53:39 +0100
Message-ID: <20251109155340.26199-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dMWrWeZb c=1 sm=1 tr=0 ts=6910b906 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_g9i7aCbpyJZyCEgokwA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: OsIYAT92sdY2KJbdIOXDQfLyQbo6-j2n
X-Proofpoint-ORIG-GUID: OsIYAT92sdY2KJbdIOXDQfLyQbo6-j2n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEzOSBTYWx0ZWRfX447alO3evxze
 5+4kjx8545AQgqHgVwChX/BTptkP5BuTTwu5ECi7MWUGHhNCxuEKWMDR7TcHVM20bsQIwkjVcTB
 mR7znz6YGNENOFwD2Id+I5x9r0NblqUpLWctZuwOgDn6l6zaS9vh6hJhnHDcsCz2Xgun5wuDTM+
 OPpk1GZi8SEGEzu8DWWsJJJyeX8wezLJY+hg1PXHiR6YI1Nst3hqPZKOcyvKKOa5AQBpZkUVEkL
 ROIIwy4DOXAvCLs5q6b2L6XUZ1ZjJq50dm77IPfUOGTYtFGSUeThz3JSiWEd4VCynDA9sYCldMz
 /sDamGczgaO0gxFO0Zsww1YGJ4hpzSsRBhZG7wPtL/tvczJtMGQNCxwce5qtyljn5KRQPDSFQBj
 KulSciBQWk+vE3DmwfSPBd2lYqUuxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090139

Add a TODO comment that ideally the ACPI/gpiolib core code should take care
of setting GPIO direction and/or bias according to ACPI GPIO resources.

If this TODO gets implemented then the acpi_dev_gpio_irq_get() call in
acpi_register_spi_device() can be dropped.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8588e8562220..e25df9990f82 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2857,6 +2857,8 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	 * here too, because this call sets the GPIO direction and/or bias.
 	 * Setting these needs to be done even if there is no driver, in which
 	 * case spi_probe() will never get called.
+	 * TODO: ideally the setup of the GPIO should be handled in a generic
+	 * manner in the ACPI/gpiolib core code.
 	 */
 	if (spi->irq < 0)
 		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
-- 
2.51.1


