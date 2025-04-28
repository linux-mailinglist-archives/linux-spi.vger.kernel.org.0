Return-Path: <linux-spi+bounces-7787-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B29A9FB7F
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 23:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268771A87439
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 21:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF25F20E034;
	Mon, 28 Apr 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Doiy4D3q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810F205519
	for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873985; cv=none; b=tLUcMdhxLd3++nLrsOpveQePgJWPt1kYvpbJPE/c01kEAtAQcDuq/NuejL3tt5qi7NhuOhSsR3lAgoEe08V7ZPjn1rWHUVyyLsq5QbmN1ky0mE9xwahVzXPIEZryEQnpPKmxh6qKmKDsFu6ewt4B6nAmYlMXQ+jW2SsDxEVMra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873985; c=relaxed/simple;
	bh=QvUul7P7AsGMFv4R3G/+ROuDAPMlgtEDwetlk7UIGB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eTKS6aQbPSpqrVedfQ/I+NsiTUvehBR7qG71xyH7KClFlHGWgqERKX71yNE01WoqXAncR1taIGAOTF/+LHP4FqoykTyYZdb3J8xiRwZrZyzaIdI9m1qDUugvhE1ZyvGyptDsdRFvyMRW1644pkVlI2JsiPKTZ7EAZUnQLa4R0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Doiy4D3q; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72bc3987a05so3029358a34.1
        for <linux-spi@vger.kernel.org>; Mon, 28 Apr 2025 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745873982; x=1746478782; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2EIqTs1TgX6bm49NLj9s9Ql9X7BAhggXRPkJc6829s=;
        b=Doiy4D3q6on6By+MY3bOL09b5mlTh1E4wRn3DWh8Q1gv4PUpuThtmYh+H9uVbBGXgH
         HOs8aKjA1ILNQ+5wwr+we2LKEmhHMR5gRcHa/+yfai4HW/Hsq4VdjrOO5qtwwu/uOsOC
         m7fnQREJBEh/AKM0uFQOpBHcN+EK5JaRXSZbZvrQhFCK+sr3nHcrhQE1Q5/ac7v1A5hA
         KVzngIGrCyPHloiNCVBqpmVsTtBcImyMs/7YGpjvW2jzIRMkLeOiJd6FqcFJK9VrHR0j
         /VEjLaLhrgRrt2+5KbG9InnFw6yiMIuoP8iulR8DiHWeab2ysnHBj5dP6iuLyTi14+Yj
         UiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873982; x=1746478782;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2EIqTs1TgX6bm49NLj9s9Ql9X7BAhggXRPkJc6829s=;
        b=cw88r69LDi14a2MfPsexdwEv+NWPskKmPuxsQOWLgXxDqYf7TrnSoL4w9XyyJcYHZt
         olXt1Bmm5Aks6xA09hqkmmhlTI05RWNom//sB77sAiByNF4JpWGKoIeavTiDtmaPoY9A
         nr1ehj51Tqx+0y1E1JmzxgTr6m8vBW+3jzELuX+tcOQoJf44mchIyqmtYPmGcp+H69RD
         8iRXEC2PZnSiMOydTfwQVVQRx/8pAlsQ8K4xCROf8ko3IJKXBTyuoU0O4WitB2I1NG8d
         g1joGLu1fKIJowUu4XwG9R7Zny9jsboMsKLB2yHXfXaTbWNRoPuWU7V31GlC/yYYysWy
         vKqg==
X-Gm-Message-State: AOJu0YwgosxecF8bz7ZKfbL5TYziJ9ptZm2bEO8X78dTp71+WiPFaYuz
	G7g8i8LFSiIRw+N3qXi5k+AitIqnRsuEMKbf0rt2cl+a1rTXXWMEa7TLEykHljc=
X-Gm-Gg: ASbGncviFaFFE77Gu6Ut8pR0y7RZoYVdhCnCFEglDuve9RnPuDTSfyfgndKsAw56uGk
	I0hOvu+Fbjhxh9ZgSso+2BRKpQnquf8Za0/13s95znRCM8LusgDwdn0nqCYTQxRHScCzsP+Rh0P
	p5PJKIeIodSnf7XunErptIGi7T51sHGI/rCRvv/FvgZp5E9tDxUOup2+SOOvaRdZ6GTnmYE6Utp
	+j4/IJ/DPHJLER6Kcjr/JOqWpSBB7MQgQnWm2kj/bhiRorJCUc6RP9YixsWXqPJUfu0GU6JS2DK
	eAMJXBd5/QAu0pFXyucbG+UogZtwX/2xtiFIgSMFohQScH0=
X-Google-Smtp-Source: AGHT+IHzkS6dTmYI2nXJFRjdvYktsXRp0acyZXyKq5290XGI313oJ5apKfMQaKbv9asJ/o2fv3/mzg==
X-Received: by 2002:a05:6830:6888:b0:72b:974f:de49 with SMTP id 46e09a7af769-730898ef2dbmr386791a34.7.1745873982408;
        Mon, 28 Apr 2025 13:59:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:cff6:9ed0:6e45:1ff9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f056ed8sm1907614a34.0.2025.04.28.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:59:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] spi: axi-spi-engine: offload instruction optimization
Date: Mon, 28 Apr 2025 15:58:55 -0500
Message-Id: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/sD2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY2ND3cSUTN3cxMw8XRMzCzPjxOS0ZFMTAyWg8oKi1LTMCrBR0bG1tQC
 9orVsWgAAAA==
X-Change-ID: 20250331-adi-main-46863acfc540
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=QvUul7P7AsGMFv4R3G/+ROuDAPMlgtEDwetlk7UIGB0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoD+wYlIGLHSGHsasichpx7lAD1+EteZmTn+Bwi
 JfGOdspmNmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaA/sGAAKCRDCzCAB/wGP
 wOroB/4j4xjnCOzRdziE0l83g7H8bQ3H/T3MB66sbUo/gUuWXjqcGWAchp215k5G8Dn3ugt2Xbk
 ElDtuHGiYuC5o5T8mEdcrTVZ9VTj79hYDgPzy/NPBiiJPjHxGaC0OhhS7F9AeszxpZu/zsCA256
 x+Q5iw9eKjL9GFJjqovqMKoMBDhivEJ6/U22HJQlpoagHTZm0cLoWlEbWDmFgy5rwfhVwsiTPwI
 U6rLa+vAWetGKYoNwjkAZjzrsBoVni+9Aqod9RnSmX6ww5s9Ki/0HlxuZE9rZ2V+t37aCAUfcK4
 oXqKuo0JkPTsyaQdsdpJmdS//X9FWNByT53EOyK9Gom/y/1v
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

In order to achieve a 4 MSPS rate on a 16-bit ADC with a 80 MHz SCLK
using the SPI offload feature of the AXI SPI Engine, we need to shave
off some time that is spent executing unnecessary instructions. There
are a few one-time setup instructions that can be moved so that they
execute only once when the SPI offload trigger is enabled rather than
repeating each time the offload is triggered. Additionally, a recent
change to the IP block allows dropping the SYNC instruction completely.
With these changes, we are left with only the 3 instructions that are
needed to to assert CS, transfer the data, and deassert CS. This makes
3 + 16 * 12.5 ns = 237.5 ns < 250 ns which is comfortably within the
available time period.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (4):
      spi: axi-spi-engine: wait for completion in setup
      spi: axi-spi-engine: don't repeat mode config for offload
      spi: axi-spi-engine: optimize bits_per_word for offload
      spi: axi-spi-engine: omit SYNC from offload instructions

 drivers/spi/spi-axi-spi-engine.c | 91 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 6 deletions(-)
---
base-commit: aba9c2fee9598d797034ffd289b0da770d9119e8
change-id: 20250331-adi-main-46863acfc540

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


