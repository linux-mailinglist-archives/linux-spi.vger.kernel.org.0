Return-Path: <linux-spi+bounces-10624-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 360ADBDB89B
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 00:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABB2C354010
	for <lists+linux-spi@lfdr.de>; Tue, 14 Oct 2025 22:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89C30CD86;
	Tue, 14 Oct 2025 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ots73aZh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD6B2EB879
	for <linux-spi@vger.kernel.org>; Tue, 14 Oct 2025 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479386; cv=none; b=V1CgYp3Fdpjoorfps2/5qthpiB9jNCznoxkLYqgxgR+0QDJx186gUWXW5xnhOUv3iOnFhyymtL4i+PAgdhxVWx3tB9aAO8DVd6hYvKALUlQWAzrHRdvQuZ0sydb5uwRer6ggBDYJ73yPkt7NkTHMgHYIjJcM2iJ2ISWrxijAed4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479386; c=relaxed/simple;
	bh=9mpUaLXzASSnQg9/UXJGW1+ZX9vnSr/ezEu7DYjOikk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bn+GGgdeIUTVPCW1wCXawu0iCDwwUy4+JvyKaUEmR3CyF+NCoaTo3ch7ZBsOi0XhF4xYJ6h9xOid0KePql/i2KwxUICAX+TYVfzHwNbgGHnLpuVDXP9s1PyYHcTxXafMO8TreGWWdOtx5CmHuIlnwF04/AW1r2kI+tfMYso+mt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ots73aZh; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-43fb60c5f75so1151508b6e.1
        for <linux-spi@vger.kernel.org>; Tue, 14 Oct 2025 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760479384; x=1761084184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFRbGHMmuFj9fckSEOxE8K2KKY0A8HOY4cZLAf2EWJo=;
        b=Ots73aZhZg53j5ae4hXXNmh4IAqFbM8/0mCLPn+hA4yRO9E2j5QdH6tYvSWooJzsSb
         kmJnxm41Hl79eV8T+j5uZcI83l42BRgv6YIsDGUI0iMiX/5pFV2MxMpVzJe2qa8rXl16
         yMySLGEAAXteBCFQ48wKj+Lx0Cs2VG6V7ohl27VODybnrlu4Wbf65+LnSg2KpOUvGBW1
         SEcjWEAKjKPwyN7CfqRzIHYvo0KFEKRGfUoxq70YDOU3sFTRBQJegqryLoyVzmfWwtz4
         wYoQ/d2vEyTWev6mixwoyufYFyQUVjOBhmVceOMe6oA1nGfrv8W6GcETW1ripqdk7yLH
         iTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479384; x=1761084184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFRbGHMmuFj9fckSEOxE8K2KKY0A8HOY4cZLAf2EWJo=;
        b=a2usUqZ7jUBYSxPEKQXU8tbgAfXFo0Jp80+Z/fCwgg6HRYtNgBGBrwudb6GJtZSxTU
         vdHZz6bzlZ3Y2pufhXwtsDu00RUMdDBr6y1WnL+yaBUCsGsbqFulsp3dzMJOGrbebZjK
         fEnpMv8i/FzvuFxr8FOESUfUnyz+soRRnDb5CYOpEoFZBOEO3EaHh07qlc0uuHdrM55k
         37N4OulSMDoV0KTqoAgeE/XgJ0FTnbOsLxpc+VDy8uWt6Ee4O1MItKY1XPxWLRVqnvcb
         TRVRXJKs9sZHTucxHiWEvHK/drcmwezigpgK83hFMCcxvTgSLwY1RpMblr2c1dQtuLkW
         +tJg==
X-Forwarded-Encrypted: i=1; AJvYcCUZk67PRt5ldz0vWgxdWDlJCZ+aqLLPt2JH24S7sAkY5+FOMze6tbiIzoSLgMIolEBNl3dktAAgAJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTieADNn4IfVuHDWnM/jkGD4FW6YP+Y2SE4/Jzr+vWZC1tIozT
	am1Nb4sUYA63t4y8o1pbkxBsGnT30o58FKgJdIBGkbqaDO87MtZqJiGTr7c8NCYNAwg=
X-Gm-Gg: ASbGncvNX57Y7AsYSCNQGfCDA7V4JRdCBk8pdZvnNWVHYGWEiOKV33QEHvl37jlPv8g
	p9+kSTaiZOWQW2FB6heTdAXOL7hfhAWXb1F7kKHdFVzDqTbpe3JSzwYGTF11omCWLj8PHpql1Xl
	1uTchqdzw/r5mZNF5OtZSW5rncnN1vVpduFOZe0nnVauLpxYgLA3FLuJaZEKKYhwDOUN4dnnbDr
	W8WqAIEmL7MU37tmeZ8qzTaDVWrd3oYzL86XtIJM3a763Br9dy0iJXw2tpZOQ1NlQ0R2nRTn21g
	s38yFSwKmCXRHDUbamrGAcWGEs7ZZvw/UjhNdCpwhp+P0d4rZm3+4kXiW5BMHaxJBWiftZxFEfs
	0d31n4V20eg5LE9qQFJ7qoFjy08pgGPcAD751ASkD46iA4w==
X-Google-Smtp-Source: AGHT+IFFz8OOxzRl/gmMqTa8+mYz1vaHsgTDN8MTZ4sbaNr/p0kWoGILPZjS87R373EPVFDDcBSDEQ==
X-Received: by 2002:a05:6808:e83:b0:441:8f74:e85 with SMTP id 5614622812f47-4418f74275fmr9076599b6e.63.1760479383897;
        Tue, 14 Oct 2025 15:03:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4419895119bsm3593732b6e.21.2025.10.14.15.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:03:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 Oct 2025 17:02:11 -0500
Subject: [PATCH 1/6] dt-bindings: spi: Add spi-buses property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=9mpUaLXzASSnQg9/UXJGW1+ZX9vnSr/ezEu7DYjOikk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo7shszLrvSwDbyfBRm0xmRcRlQ7K3DVHcCsRnM
 m6LZBNvxvOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaO7IbAAKCRDCzCAB/wGP
 wFbhB/wKCLlYsfPLWnZDyZXPVvh59Xtik6VCFqlcNi0EEfOnFjkf9jJXsF0X3dmRSLs8TmHX907
 HWiYYyJqLs2aFroWt73J+GIUyxBz4aGuYPrjnEf5/NwCKrX3LONCVLi7JWD9Gpc3Lcp/OH87dGU
 Rc3V4mdaVbqSq8trlA4tnNQaWVf11dI0OgsbYiKvC3VnByTTIYKlBGybdgGY1x6op7xWWxyegLK
 lEP/yMJ+UzxT0AYGGDHrAmUa1s9EpR3GY8y4ktZhf9Lo5knZfXndA6zf/rE/OgxfI1rJ41g2nfX
 krUXo5O/ic8bqeOi+jLwyKytH2or0e58X+b7obQ8iOlvMSIX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a spi-buses property to the spi-peripheral-props binding to allow
specifying the SPI data bus or buses that a peripheral is connected to
in cases where the SPI controller has more than one physical SPI data
bus.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

This patch has been seen before in a different series from Sean [1].

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-2-sean.anderson@linux.dev/

Changes:
* Added maxItems. (8 is the most I've seen so far on an ADC)
* Tweaked the description a bit.
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8b6e8fc009dbdc80978f3afef84ddc688ade4348..91c9de3ae10bbad76cd4f57d0789b1161ebc7a18 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -89,6 +89,17 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-buses:
+    description:
+      Array of bus numbers that describes which SPI buses of the controller are
+      connected to the peripheral. This only applies to peripherals connected
+      to specialized SPI controllers that have multiple SPI buses (each with
+      its own serializer) on a single controller.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    default: [0]
+
   stacked-memories:
     description: Several SPI memories can be wired in stacked mode.
       This basically means that either a device features several chip

-- 
2.43.0


