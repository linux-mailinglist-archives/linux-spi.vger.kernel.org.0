Return-Path: <linux-spi+bounces-4449-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3EA96508C
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 22:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3162848A5
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074241BA29F;
	Thu, 29 Aug 2024 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4vpyHvI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814847A76;
	Thu, 29 Aug 2024 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962404; cv=none; b=aWbFG04RNawhSn43IniVouTxPrwgHhUo3feCcuReY7Yy6qOTiwkFm9CY7AMDmnVg6Px2Dy+VCcUGL6BIik0YSz6Hk/VhddpFjRFjCtAWC1FV7zaDesz0mwWB8Cvx1SFOyrmZrGJPdVmHGphBzfABTHSo9CsnkGLP26HxUZikF3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962404; c=relaxed/simple;
	bh=uDLKZSc3+6b+DS4mZ9GNvlmrn/Uy/8qe+FU5WJrKUVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NInLI4CtE30NvpW4TyIVAtV++1TLCwHnK0L+DN9W1WvAcuBXxL2beqhRNjZa5FaConTSRhCLXdwL5h9CTo20uUJLBXTrRbTrty3DIgWGRP66RCkJap6a1CwWZd81VS2fMUSyxudG7ZiiXQUrwBRZi/DAtXgLYrdzIQLd9h+gXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4vpyHvI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2020ac89cabso11723385ad.1;
        Thu, 29 Aug 2024 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724962403; x=1725567203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6mAKO1L7Uf6xB6FLQZsVDkDOLx5WJyRN8bRA71hTC8=;
        b=h4vpyHvIX8wRYV7i8FXNBVubSaZedTT/8fqFkQWHF7Sef2hFFd1dAHRgn8EJLcbzxT
         8AyFRn6uSXSHKs51LML/joLWC10d/X8BR1A5V2D5l+V562BeJFdY9yV9/Ha2NODa1Mfp
         IQryveDV5GCjD+0g742EAKl1c5dvbOq+gRWGaj0XzhjjbSaEt04sgzp91cM4Fhosjf+5
         JA7pxhsJRvNGCRaBJvo8oRgiq/F9SDbP1i8R5j9E26WrE8zuGYcukPji5IFDt05nKuj0
         8MPPjEgWNAvPYINEXgi14YL8vCeyw8y7cztCpHSUyOAFzAzCywgEs2LiRWB4dyh3XUEu
         YY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962403; x=1725567203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6mAKO1L7Uf6xB6FLQZsVDkDOLx5WJyRN8bRA71hTC8=;
        b=xJtzJZwl3oNAqnxsIRGQqG85E5t+amNn/ESHqxfS8NN6jaLRY4DnSOwFK+oQCDDLu2
         yBh7XfwwYbJ8f/f1iAeSYUfKmET9OA3LTlKq1Gg8MwtGRdV5sJDP0VLZTNUuYotQsMn2
         Jp4jNl6B4GloADd1ZW8w4a6OPvS31Yh7+tyUDOr+GnItbXc/YmH//Bu+ENlATjbeVfE2
         nkr90V4sClBi9g+XWRImKvNMAnnT/WHa6e+mvu7F4X5GotXNq1AIs2keDmxboJXs2pXL
         BYOKqXh0hCTg7PNGeXYqGOsQneMIuGusy9hWkiYgJs4d+G+B03e4UV+NVeMvGO+FUl6z
         65Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVHWe8zWfcb8AserWRg21MZ4CjhtsYDAYDoZs+NvkVD8qJUG72FIbZFfUi+Wuz26275t86lDWTMTURH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2M5bUSQ0qTMNjo1QHSlQreOr98oYMY6ypLr12jbxUyMnI9Kwc
	NexkjuFuxN4giZxAhfLbSTTo27pxjO19SEC7RMom8il7Xw0hZeam
X-Google-Smtp-Source: AGHT+IH3vovA0aK2ROQvRVWqCjQk4AzK9ChEhdjzl/8ASQriXDaGXSy+YkvE6tK0BY2r9Hbjf0e2pA==
X-Received: by 2002:a17:902:d505:b0:1fc:6a13:a394 with SMTP id d9443c01a7336-2050c23829amr45616425ad.23.1724962402708;
        Thu, 29 Aug 2024 13:13:22 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:adb0:3b7e:78c6:e307])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205227baebfsm1996165ad.247.2024.08.29.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:13:22 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] spi: dt-bindings: spi-peripheral-props: Document spi-cpha and spi-cpol
Date: Thu, 29 Aug 2024 17:13:14 -0300
Message-Id: <20240829201315.3412759-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'spi-cpha' and 'spi-cpol' are commonly used SPI peripheral
properties that indicate the device clock phase and polarity.

Document these properties.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 0bb443b8decd..b2e2717f3619 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -29,6 +29,16 @@ properties:
     description:
       Chip select used by the device.
 
+  spi-cpha:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device data is sampled on trailing (last) edge of the SPI clock.
+
+  spi-cpol:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device clock has a falling lead (first) edge.
+
   spi-cs-high:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.34.1


