Return-Path: <linux-spi+bounces-9129-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60677B0AE40
	for <lists+linux-spi@lfdr.de>; Sat, 19 Jul 2025 08:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064C11C27312
	for <lists+linux-spi@lfdr.de>; Sat, 19 Jul 2025 06:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BD622B594;
	Sat, 19 Jul 2025 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="I+2cPwbW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE71EB3D;
	Sat, 19 Jul 2025 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752907342; cv=none; b=L9Qs6UvHyJ0GVPnleL5sUTta+52LE4Jrme2PD0fRSC2jG7706RS8+5r3bHJvcWNrSoJXQsKaebVYC04USZ6YsLLkKj4Xe6Hoh0NljGaP2c2AiImTM5wFgK2kKAkvdFiArV5G3/+CRJ57XyV6tSVS5SXxAJF+r2d9T9q2ZTkG+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752907342; c=relaxed/simple;
	bh=ZaaaMC9y/tvIrNbJiz0ihB/v219ZkoS3fwKyb4kFE0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5r2l/6VVAJiJcCwlZjhk7QUaNCXrM0zWwBKZAmaIU0t+u8DKV5rHCZpBKU6lYaemxlSM6OKzACs4Zu3KJ45zjcNu5Tr0ljfqBMXwGU2IThk2NxkIKSaF+ZsYbRDvibV7tTBMZITy8+rGzy1dYWjmD6d23liPYmLybPULZXDS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=I+2cPwbW; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09B681026E997;
	Sat, 19 Jul 2025 08:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752906861; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TZcw6V3GROU8ELqtLuN73sY9LOkBh3a89bo1yjYcRlI=;
	b=I+2cPwbWUHhxZrjezH6Kj1GCdcMTRJWPQtGV3TZ6r9GjGp05x0mHCwYzUurNJGgofGKhpw
	8M2bp0yJk8znvbZ/SMC3Mm6r37CooKgjIiIS1ZUWauppklLLDkuWWxoXne7nzL2SPURfuu
	oCECfegPLEB7uWOmNY1KTBTnxNXCZUoKhipFS8Bzs8GcEt3HU3qtPhBHdH1s4fkFeoqCOu
	HmjAWFTvmuCNAFt1IJS9aZ1+PYAqCKURLwddmbfpVVRlJpq9WrDKiKeqDb7V3aH0/zs95Q
	h4cr7lYbk7N3ybczHTnhKDEosrgTnhjJ0JAIzVNOlBD1Waf7I55sLWWlqI716w==
From: Heiko Schocher <hs@denx.de>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Schocher <hs@denx.de>,
	Andrei Lalaev <andrey.lalaev@gmail.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Rob Herring <robh@kernel.org>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: trivial-devices: Document ABB sensors
Date: Sat, 19 Jul 2025 08:33:52 +0200
Message-Id: <20250719063355.73111-2-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250719063355.73111-1-hs@denx.de>
References: <20250719063355.73111-1-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add documentation for spi based ABB sensors, which are
currently operated from userspace.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 27930708ccd5..25260c2b81df 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -30,6 +30,8 @@ properties:
     items:
       # Entries are sorted alphanumerically by the compatible
       - enum:
+            # ABB register based spi sensors
+          - abb,spi-sensor
             # Acbel fsg032 power supply
           - acbel,fsg032
             # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
-- 
2.20.1


