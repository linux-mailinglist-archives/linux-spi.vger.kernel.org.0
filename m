Return-Path: <linux-spi+bounces-7816-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88864AA605D
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 17:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107791BC1441
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E020B81E;
	Thu,  1 May 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJZzoNfK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB73202C5A
	for <linux-spi@vger.kernel.org>; Thu,  1 May 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111735; cv=none; b=GHEKM7eOEoHF3Bks4019MVODX5QFHB/b9hIgh+S+TXgqu8Hd7gL/gfYEofZwsqyvEpDCGnDDIvWKNqtPNRJEYHnKGspdQXTp6x4UuNaWH8/9vL4D/p9Gjnx3fwwLdJHnHCFDAgp6f/ideWUjzrjts5moB37v+eMOAPWotIgJcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111735; c=relaxed/simple;
	bh=B3v13NXCER5k3tKhwX7vqb0mye7ltzvO1U+oUASNdgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bAAPETVn3VRriHaUusDpU3he5noJHQHcOZxhSg2aADaufhDisqcg6HsQF2McbwLOarFlEPY4e5qBIcRrDbXtTG76N2Fipw6ScmxiTQUhT+mGgT9SvhI4etW5USNr+mY5YCjh7CVqRIo/gpFuaFowOdmnr07Vn8JG9WQf+gZ0g7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJZzoNfK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe99f2a7so1733085e9.2
        for <linux-spi@vger.kernel.org>; Thu, 01 May 2025 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746111732; x=1746716532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Z1CSMjo4bwXac777IKPq+E/WNf0vRomoDLRk/F823M=;
        b=cJZzoNfKaFVs6Wa631fHAnHWOWAi9tKBcGDVbS7PCUwViKCuPJ6mw81yJWwjhxjP7I
         GzpLWXRPuurO5a9CKsGQVBD5gFO20r5wziwHOAMIhBjCTaGvvmxrRGskZn8NmFsAGRqb
         PiMBPpaePBnbC0n0wLuH1/Y8jUICHDOJPP9q+GclCkrq9GtV2yhg804ykRTJU9qpGzIr
         H86xd3uqLPjnQoNFc2TCH/3no813MUhZRClYrlVzUFcm7/Ntg1EBFwrzjFYzNfLTQ9eb
         nnlWJZEnPNmrAa7t9szWIB9Z1E+On8v9iuTZpSxcbge0NPSBYuWCzkUtLTiITUHjQgcH
         GTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746111732; x=1746716532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z1CSMjo4bwXac777IKPq+E/WNf0vRomoDLRk/F823M=;
        b=P6jo7o7Moo5hxdknHsg81dRxa4EsHO+E778vv42dPF/OSef7D4RuMXG0i7T5Ij2Dyn
         anD/yTqcY+GF9wfmUmJDmYBuOs0nSKTi0dDY/g3VIgI5G2f/G5Tn+15p51g6DjhSNfdU
         nyQPAXrbPf7vEKoYDcptpLqdCv3lnAlcBMntE17jcmKOQZKc+3RWqOMYJuIitizozf8M
         eNtiTP/zJvjgR+jeu7tSNIafygK5HsqN3hVm13u4gbj+W/pU8vbmhZf5LfHA1jEpEUF4
         Sb7W6r8XJvou6+OYIjAe6oHC7CNj9H58rGEy/GOPT/8RmcA30zmF5xG1yOXxu1SFNhHr
         SJ/w==
X-Gm-Message-State: AOJu0YxTOaEYId3Ommkn3pSS1Z3+ds5e8Qqm0h9QHX/psX60we37FRE1
	HY/xrvoKFbKTSnyoXDex0VRm2UROOIrGtXMwvSLAcFiIzuyIfkaxb26y5R1fh5g=
X-Gm-Gg: ASbGncv9YZSSdqTJAjnbg73xz+bpGt/WpP4a5vmXIar6bqWAlvWvORJtriIp6RpnGK5
	Yd8bsf7zVytzJB7ANzVhMIPVYvTtQvjJo0FDwZm5fgFgI00+nBfL+qPAJ+ZtXD/kIRGA7vEM86F
	hkFP4f2MElAHPMhvaStTc5H3dL4qCUaVVdrtOzCufF+26wWI19sxAiWBTqv9m04jKTnoSAKsvQz
	HVd90qV3qJGt79z2GjbvvOE1F7/tPk1jLpapxjvmEQedYeHLHJF0xY5M8/jf4sDS/q2XaZrKkup
	Q61eSSCAWWuq74Yk7XYP4UP5DWCFk2jMjOferYNWpAj8C716R6wtSGBm3Kc=
X-Google-Smtp-Source: AGHT+IE0ENZdHGkQvgGoH2mnDKlJJ809LkSCtAMhmB4rpgM9Z08EWOHgpBqjUop6OrvJ3Ac5c98Akg==
X-Received: by 2002:a05:6000:1846:b0:3a0:75ff:261f with SMTP id ffacd0b85a97d-3a094178fb0mr816964f8f.11.1746111731899;
        Thu, 01 May 2025 08:02:11 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a4702csm1033190f8f.40.2025.05.01.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 08:02:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 01 May 2025 17:02:01 +0200
Subject: [PATCH v2 3/3] spi: cadence-quadspi: Assume device could match via
 platform
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-n-smatch-fixes-v2-3-d2ad9c1f2e67@linaro.org>
References: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
In-Reply-To: <20250501-n-smatch-fixes-v2-0-d2ad9c1f2e67@linaro.org>
To: Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=B3v13NXCER5k3tKhwX7vqb0mye7ltzvO1U+oUASNdgU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoE4zs9gNikiLaGr7Pqc78Xp2+VrLMMAjp88bwS
 hB6yBtxryWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBOM7AAKCRDBN2bmhouD
 11VpD/wNiGdprHFBTqCt2CnLkmyOfWKabgzUmeNPQie00KzOgJVHUUjWU4fQaeI30mVt9rfpu10
 llp9+NafbiQoqC/9fHr8ckF1T8bTk0UxAAmqyeIoxupKtWuT8SpFRVhzfWUWaxuAzgzji3dPDHK
 ljhiroQ5K9bYLCIjJ3DMJe2ajG458Q2H7Hj2Pgm0oyGZP6zVIA7fnv4p26E2xOIBkGaZWo57pFe
 bjmmIUqrklHrbwgPT9JjxthHgNtY9wYmOEietCJq06B9o3ATCvBI8OsvrP2VaachROYBHaEKiM8
 9kifoZWrIGLKbeMbGnJwami0uAWC1TckkzhDv7mVsqLKfToy9rFkSof7/756aD555PbJ9WQ55WJ
 ctyJMPc/lNwv7/qwagVd5gAb0lMZ3MWpgS+ZwEW4JQADcjC/B2Qvl2z8S05COKdPgBV8VaX7Y8p
 UuPfvFDlcmfyuy9ehhlRV3iO/nErNWoZK3M5rfTS/3jBgM2xcLy3CkdJ6+r6Ec2DJBVGtKG65Tu
 Tg87N0s6R+JDC6j2EAjrHOK2giHvXT23YzVbekBecuiJUBmydauJwxTtDQmzpDRFbWz0cB9v+ti
 5xN+x7ArX5Zwm4w2++0vpqUKE32Jr1CVH3vNQcABVwPWPvo6bd0gkioWh9nKgr83W+A39JkCwYD
 09YLX6LPBaP50/g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver has only of_device_id table, however it also has MODULE_ALIAS()
for platform name, thus assume there is a configuration where this can
be loaded outside of OF system.  In such case of_device_get_match_data()
will return NULL, which is already checked in one place of probe()
function but not in the other, leading to Smatch warning:

  drivers/spi/spi-cadence-quadspi.c:1942 cqspi_probe() error: we previously assumed 'ddata' could be null (see line 1885)

Driver should be consistent, so assume device can be matched via
platform bus and of_device_get_match_data() can indeed return NULL.
This is also possible with malformed DTS on OF-platform: no unit address
and device node name matching driver name.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index c90462783b3f9f05e477d337ab4187224992c0a0..fe0f122f07b0206e80cf89bd031106bf8051c789 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1949,7 +1949,7 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	host->num_chipselect = cqspi->num_chipselect;
 
-	if (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET)
+	if (ddata && (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET))
 		cqspi_device_reset(cqspi);
 
 	if (cqspi->use_direct_mode) {

-- 
2.45.2


