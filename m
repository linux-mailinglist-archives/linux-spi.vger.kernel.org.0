Return-Path: <linux-spi+bounces-11089-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056BC3C13C
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D3F1AA802F
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929182882B7;
	Thu,  6 Nov 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="aVM6n5z1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1391729B77C
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443088; cv=none; b=WzNQp7N0rdFzMbk3tskiHMgFeX5I74YU61400XwyWcZmOvxl/YwRl1Kl1E3TgRM/4z2Qq6INYmxMXp0wFDs4NdxEzD9J4Rqu+ZPmvULzlG8E8/spMlYNKGxRvZT+GX+JEYilEBHS3PKGgVcfSqc1gFo9iXdEyPdfkA3/v2eztTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443088; c=relaxed/simple;
	bh=zyGou655DgPVWbvzpRGsIISTwPvEcU+Qm+OetkBFuJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQjlRIvz9VyqDu8ceHclctuyOAo2y2/ZpZF+/sawy5xVHgpw7ZlzRgNsxuxnbCALpTzAy6S2IbEY8N7/vQcnZgbJOVplx+ADr4wX+EPzxhWYYof5QU7Jm4h/Ubp0HTtzz/W0Cny91fIGGmcycOFamYvwkTOWU2P9dF5SEQKCoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=aVM6n5z1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1278794f8f.1
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 07:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443084; x=1763047884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdoIcRkh0qAEi2h/VedrLcowdMk122XxoHkRGxzNBLc=;
        b=aVM6n5z1uAFpFgePUg9wHhkpERhSDjziYWcayZ0caqNPSDpvnmjLvg7zjipKEKXReq
         39BbbStvCa8mrwXBgPFvuoi3VFiJN3tpoh5NZNIqJVS6X9IQ3tOZ32ukdawEVVW4QS6D
         oUU9cb9cnVLUkT9aoYrm733298++GTdXiO7+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443084; x=1763047884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qdoIcRkh0qAEi2h/VedrLcowdMk122XxoHkRGxzNBLc=;
        b=nF0X0i7XT3aOziaggu5QNwVMMLx/SFVXkw88rAWS0l0ES56f1kVqK7135z8ZfFWCqg
         k2OVqWKit7rVgkdYtdqA5K4f0chQ2sQe+NHV+GxG2Mw7ek50YMM97+6d5lho6XR0HhCl
         drFiPxwTbrcB90ffh17SWhNp9ZqQ6f3Nl0kL9M21kpIgZ324VXXX2tn5nd6bGJ2J+hjo
         L80GYtmedXwxBDnDdgImwcPIsGOIkQgk28ZXQSyBfe2auJ+Xr5O5ttRBFPXxi1uNwPxT
         C4CqT6np/DOwkFvzCdALvSBd7UG0I2jy47WXkbIGlzdncRkYi05SE6pNv7JNF4fEMs38
         IEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHehdgTBdbKoPiqvvzBtn33Fi/oi5kYZpq5KZQy79U4pINrycSns/QOww+qIcK7DR277OhHAR8X8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxioO9YCphUSUxh7y9wmDKO9/sHRsP4NE8C8aABgZWlUYL0meZo
	kdsM2QiaV+nwB8Zk17fK1i/1MABsNJqP8PS828o3q5sFVzNtUYtVm5AD6kINVLnU2Tg=
X-Gm-Gg: ASbGncuu5VrmDR4iiyL1prHwcKROOHiIDT4eMTYWHlcIEDdUca6MJfdKtJwK+Djn+J0
	Fr9GNYJ1vtn+aJ24qzl716Ae34K2JFOVl9mpwWSZUzyRG6nmWLyfbqBIpXL2fKHFG+WpLwIXzij
	Df1Cnp0ke1GYHEgCgOEEks4DkCkgD5JIuhHsatXD+tjWbtc7dWasyXEisNaQ/skPNPxlvBc0Q3v
	1gBon7E0Rh6Yo/AmuRKoMmepYaed81hwZGjAhnHZWleakCLsxpcwU3DOxki2U7Kff28Pgl24qSz
	cb4wP8G9dVVlrV9tTDqeOxpXx3ja1X+qM4da7315hKWf9nUYnr8Ise6xX6Smu72hNUlFUzcl9Bz
	uzakE8QXYPzuUVEZmwWFFzOtpnkRIx0uYKNE7RtIt7VyOSTQLxyE/jNhGNYd1Ul3nRdBQDC65D+
	NiT1uI89rxf2O68aQmxFYms+ML
X-Google-Smtp-Source: AGHT+IE11tqb7MERlvkENeEoJrFa0Bnsi91DGqfmPPudaUG+82H0TbZwLnEcFpdLbyB2kEFZoFWXMw==
X-Received: by 2002:a05:6000:26cc:b0:425:82b4:a099 with SMTP id ffacd0b85a97d-429eb0d7665mr3707607f8f.0.1762443084189;
        Thu, 06 Nov 2025 07:31:24 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:23 -0800 (PST)
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
Subject: [PATCH 1/5] dt-binding: trivial-devices: add arduino spi mcu interface
Date: Thu,  6 Nov 2025 16:31:15 +0100
Message-ID: <20251106153119.266840-2-r.mereu@arduino.cc>
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

Add spidev item in order to describe in Arduino boards one of the
interfaces between microprocessor and microcontroller.

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2eff6f274302..c44fff4ce2e2 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -59,6 +59,8 @@ properties:
           - adi,lt7182s
             # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
+            # Arduino microcontroller interface over SPI, e.g. on UnoQ board
+          - arduino,mcu
             # Temperature monitoring of Astera Labs PT5161L PCIe retimer
           - asteralabs,pt5161l
             # i2c h/w elliptic curve crypto module
-- 
2.51.2


