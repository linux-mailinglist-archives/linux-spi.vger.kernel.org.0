Return-Path: <linux-spi+bounces-9666-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D9B355C2
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 09:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC37686CC8
	for <lists+linux-spi@lfdr.de>; Tue, 26 Aug 2025 07:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBA6259CB6;
	Tue, 26 Aug 2025 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="DkN4PJk8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF82D0C91
	for <linux-spi@vger.kernel.org>; Tue, 26 Aug 2025 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193965; cv=none; b=nUBPmDh8g6lIY0CyrfrHDQBRU1nzzPdG/jMLQQZrQ11F6w1OOa9MdwUNoHVhz5CxfWlHEmWTi526wjxtDf924LbFNB2qjGVM4AyKkyXKbZg98IP0WAX5tYoUYEkVirKlXrR2c8rnZ142hZ59pw0y4/zVB1CQKXupxv5pyAC2BgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193965; c=relaxed/simple;
	bh=/HFnlMgSCUJ+ouNs1zy9yvEOkJt+1J45Kv4lHAEHgbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dycjZ/mzcq98I5taDDrvCZDoOZDY73Vb4Z5wxP0fGUD9MnWDbkoK21WnjRlrcmOaH9OcpFyMaf8fZCjgQFGrnLcuHTI3YSxhRFLngU4UuDrEJI+MprEb8NSSmAAJfsKXxlNtoS7/ZVnZ4GmfVf+OiBudgPzNgk3JnrlFMKmLmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=DkN4PJk8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb72d51dcso718734266b.0
        for <linux-spi@vger.kernel.org>; Tue, 26 Aug 2025 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1756193960; x=1756798760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz2vvjQIYGtQ40QPGNKGGxUN0gUATlzCWQqeOHTGqEQ=;
        b=DkN4PJk8FHMwuRa7R0F1gtJGNOHbtpmoCmmcygshpB7piFMP2Ccwks8EI+/0wwsWxc
         8h2hDLP6KMI4Tq3GN57QAw3cEuxu0SQ0lF1zMxMIJgcuM+D3he25FDoCFhvHQUte+woI
         1t+/jRwfPB3pHNxivc5ITwfuZTqyFKPiVvNL3hiKrEz80o+lzE9VryCDPlKjJRBNPHwJ
         alzoIiM7C82Yy83UdV87EKBVadgzQqNPowqbStgnSZL3Cz7u94K0rUe6Bbutz3c6pqRN
         Nd7UVnZJbHTpW84cZeOWG+0FRmI7ksscGX943F4Ewu/Fgp8w1WgPveHCZ5sXundJXbgY
         ASnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193960; x=1756798760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vz2vvjQIYGtQ40QPGNKGGxUN0gUATlzCWQqeOHTGqEQ=;
        b=SWEPlufGygupA7wN3eIq9i7f8SVKZr4AHpDcB3eXey0hLutwFyUdrGEJdrYrfBiV83
         YfjQpW3MUAugT/2mvC/mKkytDyUDZCtY5VAC1iiJWupT9g9q2xgqPVvh1DuW5PxFrpub
         wGUpawWIl+JMi4HcOQCgw/LL/xFhBRrYfUeyrQfwkR8EuZvymPpIwCDzkouWeY08bbG4
         yxFR4aeMc/WFPRHVWcDwjDc9aDyaT+WvWZ7daKKpD1n7BXu50jP4J1zBiefgxeXtf1NL
         isracVQXvj2xjhLn1grs2f28Hod3NLtPoyzaU4eC0BAlsJCtxHbGsy7HXcsKYLaYqRu1
         OOxQ==
X-Gm-Message-State: AOJu0YypAcFBMBLHSmSzLbg9ENCfFPWenjKDbLybzAk3L8fZwBxmSR7q
	rgw5UfRyYA9Al+30ZrN6i47bGYfElw9PMwKL+z78xUmyfSQKfLNV+pom8ywFpziEDbfGfk2XOtg
	8oMnudA07qhMB
X-Gm-Gg: ASbGncttNoltcPUdEyX8cDDhO2vxQu/gh/QeCVzR7eueW9Rid2q2ywKO07+DzBPGo8B
	KD6+ABoqPwhXV7XBG+eOknkrKzI6VmgnfZeqC4NqDj11ruotT/PBKHfPMrDz5/sKEUBF3a9l2Or
	J8RJKX0lwsJuA+xLwPQlQPvMQ/66+qY6PYevNEb1yJJpY2qS7ZLRom9imoIq0WwQYNZEr9apfkL
	lgM5IK67R9mlYzZyD2bPS9ly28f6AfB17ejFOQOAv89kdDxhOD+6VTY7+EczcORB4+FshAiD2MH
	V+QvrtA0aZgXma9CvMGzyeMSbAuQ/+1qM2BvllFmBIhUCQGRG4b9gDz7IDAYo+vO+G7+sSGm5eh
	YJr76DYKMOP2z1V5m3r/gbRB+LnQ4uaWBPky0oQhebQ==
X-Google-Smtp-Source: AGHT+IFOKqPvT+ViwyjJO+QTRVwcmX2p7RYupWJT/p5+nhuRGzHUWbh6XjBgIW9A8TUYYBMnfnUHdA==
X-Received: by 2002:a17:907:7f91:b0:afe:a152:c3d0 with SMTP id a640c23a62f3a-afea152c9f6mr189294166b.17.1756193960202;
        Tue, 26 Aug 2025 00:39:20 -0700 (PDT)
Received: from Jimmy ([213.244.170.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c312c4f88sm6420768a12.24.2025.08.26.00.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:39:19 -0700 (PDT)
From: charles-antoine.couret@mind.be
To: linux-spi@vger.kernel.org
Cc: Charles-Antoine Couret <charles-antoine.couret@mind.be>
Subject: [PATCH] spi: add SPI_MOSI_IDLE_LOW support from device tree
Date: Tue, 26 Aug 2025 09:38:47 +0200
Message-ID: <20250826073859.18827-1-charles-antoine.couret@mind.be>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles-Antoine Couret <charles-antoine.couret@mind.be>

This flag was introduced but was not added as device tree property which is
limiting the possibility to use this flag on real devices.

This flag can be configured as done for other flags.

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@mind.be>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 5 +++++
 drivers/spi/spi.c                                         | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 82d051f7bd6e..47025ebb5875 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -132,6 +132,11 @@ patternProperties:
         description:
           The device requires inverse clock polarity (CPOL) mode.
 
+      spi-mosi-idle-low:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires the MOSI line to be low when it's in idle state.
+
     required:
       - compatible
       - reg
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a388f372b27a..8fd2169befe3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2372,6 +2372,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_LSB_FIRST;
 	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |= SPI_CS_HIGH;
+	if (of_property_read_bool(nc, "spi-mosi-idle-low"))
+		spi->mode |= SPI_MOSI_IDLE_LOW;
 
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
-- 
2.51.0


