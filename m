Return-Path: <linux-spi+bounces-2818-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0398C2E13
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2024 02:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79E1284117
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2024 00:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A09D18EA8;
	Sat, 11 May 2024 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bNd6Zxbz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4E23AD
	for <linux-spi@vger.kernel.org>; Sat, 11 May 2024 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388603; cv=none; b=to97xE8EEG7rk7e1lFJ4H2oaGBpAzUNiR2grDaVptukI14c7DsJJAAGoUtSbGdi4cLGU9nqH/iXjlNRaZXW/pdAEMa2pdcUEmyPn0jKHpSqpoe3ws1/hWBOFgzG1DFGWtCE8rnrhRigcPj1JTzjTJWO2VbLB3LIpZ2ZimdaWpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388603; c=relaxed/simple;
	bh=7uQzDb4mHzMFAAji6LQjuiHftGdIMfQwB9bGqhKl+nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3mFZnJj7vAD46NbG34I9KhOgTG5QSnMA5mA9YpmMzdJIs+cjh8/IhRiszeV67Q6pQBrT8Cvv46zXQDN5XjimQJLdolXyT4ae4wcMlIUfczoDjyT+ims06tiQ9QaFFrccWKfxLvkxQckmks6dYep9BIVfvcL5BD2LPz32YeFNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bNd6Zxbz; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0f07746a4so595309a34.2
        for <linux-spi@vger.kernel.org>; Fri, 10 May 2024 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715388601; x=1715993401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0IqckUIZjVVxXVOxgac6w2cx3AmMbKz+eZNoT7XiC4=;
        b=bNd6ZxbzPbrbmMb4qJJayI2a4grnnbOaKAH2gCGjL1pXoNQBwuoAavz9txl4fEj7SI
         ZPlGrry1vS1sZgPdOYOU42F9Yzg5axlUcgFxpSojzHnM2z2EDEMWev2scImSJT5C5fWn
         Mz6XoupaAQFkxZBUl7pHqoctVwCdUip23ui5WXkv1BYNFS2gqa99pvqIKCoEBqIfyI8e
         n915D+W51EGCSZ7n/9dR/Rh/b8WNa+JCRheQcJN62yRwLO77IyxBOxYJ0bKcwVXazKfI
         6J6FxQLvdWpvqKWO3wyiwUT7O+iYpY3GchxLgPCzEXLS7bWKa7LM9s/WzxqthKLf9C+j
         mJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388601; x=1715993401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0IqckUIZjVVxXVOxgac6w2cx3AmMbKz+eZNoT7XiC4=;
        b=MrZpaSbPGmxtKH/L6Qd7qs1T5bxEqqtdP4+Zvd3oftLGEY/muvcqb+GB+7KbLvvKVI
         P65qVCNnizzuo5qtSYWpJGhFEnDoebHl4e/v8PN8qT+SYjoixLXA/l9REDK3he8lF+7O
         dxbN/a3z7AytjfRmqjOtIwyFa3j80XfdnmqdEw6oxcJ+6M1OMVqRdjiZ6K7U9aksM2FS
         9bEv41Y7553NtLYhPqnZMoC5P8AUPaTN2e11Y/8FfmMRXwAbqVmrCyCalmHA0h1Zz1LB
         oxl2wtVzMqJJ1Sydh0NE8iOd/0+HwC39buqo/UkXF1EHOagi8Xjl0w68gp1crSB1Mez2
         O1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFgVz2WWL9fPXmROjo1cOr8vdZkZns47HMGrPMeg4idKFBtXHzxI6KmHhUoqfsOdyXJ5/L/z+fDT+NyJOk6jA2spuhWHf+ru9j
X-Gm-Message-State: AOJu0Yy74pntB7+/JUiq360DcN7/d9gwITOApqoFH5u6TUmxKWbLHVg4
	z9lfJZ/oUm4/rncQr6CEpTGtX+BCryH2VTNgWoMyqQ0oQcX0d4n8YQU9lxyNMgQ=
X-Google-Smtp-Source: AGHT+IGUPIA9haCNiqxSQz+aWDhBBucJuDctWs45cFqSghUH6sJTwdF42Ovi6gpJML0oFTLvmhlgmA==
X-Received: by 2002:a05:6830:205a:b0:6f0:6da5:34f9 with SMTP id 46e09a7af769-6f0e92c8b92mr4444723a34.23.1715388601088;
        Fri, 10 May 2024 17:50:01 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b29015a3dbsm321132eaf.46.2024.05.10.17.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 17:50:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v2 5/8] spi: dt-bindings: axi-spi-engine: document spi-offloads
Date: Fri, 10 May 2024 19:44:28 -0500
Message-ID: <20240510-dlech-mainline-spi-engine-offload-2-v2-5-8707a870c435@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The AXI SPI Engine has support for hardware offloading capabilities.
There can be up to 32 offload instances per SPI controller, so the
bindings limit the value accordingly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:

This is basically a new patch. It partially replaces "dt-bindings: iio:
offload: add binding for PWM/DMA triggered buffer".

The controller no longer has an offloads object node and the
spi-offloads property is now a standard SPI peripheral property.
---
 .../devicetree/bindings/spi/adi,axi-spi-engine.yaml        | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
index d48faa42d025..c0668aab8b2a 100644
--- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
@@ -41,6 +41,20 @@ properties:
       - const: s_axi_aclk
       - const: spi_clk
 
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    $ref: spi-peripheral-props.yaml
+    additionalProperties: true
+    properties:
+      spi-offloads:
+        description:
+          An array of 1 or more offload instance numbers assigned to this
+          peripheral.
+        items:
+          minimum: 0
+          maximum: 31
+
 required:
   - compatible
   - reg

-- 
2.43.2


