Return-Path: <linux-spi+bounces-8859-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92369AECBB4
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 10:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CD5173DCF
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693981F150A;
	Sun, 29 Jun 2025 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlaWiyCB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E871E2602;
	Sun, 29 Jun 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751185427; cv=none; b=MYuh1XYAYofNgtxC/sHkEQL+AoaRdMz6L4YkL+rTS8MGT4TkGc7mzOycJsRw8mUwuw3StBTAI0sAkV63RRno6PR6z7wn7LqSTgoUD/rhgWpH0gtIvPRWTDv5L+g4t3oZO2b9T41V4hnRBbzWQe0FnHgIenaR8US2s76onS+HKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751185427; c=relaxed/simple;
	bh=ETMNqPLnrAXwhjSmox3seEy1rdOzecBNyCB7CgBbOLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9WLmt/G+cG6q1V3sH7PNUUtphEA9WvNgQD+EYbigFVy5rWwz+dB/QVWKgfZUncyTBttsmP4UOjDPljYcQG9nr5r6USyvTjugqzkK7rHqN4322A25M5BfLbjRLTd+7tVTcBN6jTqfnp0iSA4Ti3RA/5N3AIhmf0KsosJw5CTP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlaWiyCB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234d366e5f2so11013805ad.1;
        Sun, 29 Jun 2025 01:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751185425; x=1751790225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5t0qkAHCUwUVEonnqGFQqn/6cdBXFEA5e8qoGS3Oz8=;
        b=hlaWiyCBYs7hqlD/s5bOWWzS5W8HtfDBZDcivYgpDNCIP4A4wKSsyXiQ1Tbm6fooPT
         el8wmTkPNnSz8wNREZLvVJIaivJW5jhucwek41It8OAyKbdhB9pem+fcevb3BOj5MKVy
         OlkJIY1fj5Ou1Uw3We7wfiZ+M1vTg2EqKWsEVyjhbk0IW5ku08eavPaidqTrKiKgOfYD
         DUcvIqfUqNjQnLP1XgvEvegOesLs/XrDslGTGsuZUNPnNs6tTKYwSryYVE/BovLrPIwY
         ij5eTk7w3olUbXRjzjwcFb84kcGYGtVneMTGFElEy6XwOiEj2ERqn8Mu2i3mW5S0yuvP
         cHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751185425; x=1751790225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5t0qkAHCUwUVEonnqGFQqn/6cdBXFEA5e8qoGS3Oz8=;
        b=l2ePVDcx5TT7F30WnC1xjJoJ9OzR8xCHFUeGB8trCP//L5GzFfDq1Mn1zj2hMOO38A
         pchm1MJ9N7uFutwYEYdMhgqijM6K2tuWSMP9EhTkAd3JzYxACiJaXOyRw1x4BzsbLCMZ
         0lbtEIvC/2oafKalersMOveI6+wyeCnKmAezVEEobEllCaOvSUzn/wTGx/0MNrJqOua2
         KSBcokDyR0ADg3V6qi0NI6lUv+b+j7BrTSrPDlB4r69x3GN0fggbrSbwCEVIOk3G/tuO
         N2n5PLqm4aap0QD2v+5CcTe1wY+U8PzF9+ytUpVI9xJMQ11Kn26VFXin951IopNaN3gg
         HJHA==
X-Forwarded-Encrypted: i=1; AJvYcCUgpAN2YoRYByJAfSLGgZF63SLcVI2ZmAL7ZZV+HChMXsAuzFH43TDzlFABktam89WLChgJHSn0k/Tj@vger.kernel.org, AJvYcCWsfERunAV25EM0f2MPCqv7J48jvZNvfPfmeHfuaJetOcqs8+4qb9+41fH9nj1IXwuort95YPUoyazVldY8@vger.kernel.org, AJvYcCXXHBMsBo7gTtWM+lbzeEE+4wlH3tKMI9NPr3buwxAxM/52gG+er+yROdvvOp2OSa0wXrnkCiBhZHVT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+chJz5A5HXOi7mdiGMawOtD/Oeklq9c8Ktr4Gq44pwJ6HYPTp
	OxcDvi+SyF6WNI5+MefhF02hDSPS+sM7u0Z2P+TDF05lbLnzgWBP/j1KD8BEVRxdhgc=
X-Gm-Gg: ASbGncs1YmgaodfiEf9drp8CsXLDw8i0JUYSghmqm/uUCBeKn7fe6grrXq9wBKNI+Rt
	pGEnFxa1uTN1uW+No69HNHHRxRhBapXga33FOqehydpRaxE4YQz6EF//x5nmF/ZpV5zNxOuh4eu
	zmaAzEFow+VK7qs5r+FJg0oCKa12Q5GXSP24YmpkqbwH/FRJkOgQira2FiRp8+bHJGlFUmNrxOn
	GWtj3sShN8ygPoS46NXHfQFQVPRMUF7IrW89ij8EVDzuuDk+v1ms94s8Qh3nLa29bgwumThxLxH
	UWXHc6R9nTJWCV6u6daJd3fae6kiumb0V6+rHCpaMRmimt3FRLm//A==
X-Google-Smtp-Source: AGHT+IGbMuEWFzEQmcPfSGUyuO/vpiR0F/dpgN6q2wxjWT/5kSKuK3KVHvhvvINAfAKvfiDaNX3KCg==
X-Received: by 2002:a17:902:d607:b0:235:129a:175f with SMTP id d9443c01a7336-23ac46527famr141581505ad.34.1751185424260;
        Sun, 29 Jun 2025 01:23:44 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::168a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542661asm10495839a91.26.2025.06.29.01.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 01:23:43 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Sun, 29 Jun 2025 16:23:10 +0800
Subject: [PATCH v3 1/4] spi: dt-bindings: spi-sg2044-nor: Change SOPHGO
 SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250629-sfg-spifmc-v3-1-28db1f27e999@gmail.com>
References: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
In-Reply-To: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751185413; l=953;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=ETMNqPLnrAXwhjSmox3seEy1rdOzecBNyCB7CgBbOLg=;
 b=Ua4qsIQdrMlRlRlRmLVxWOFnI0KLWyYbMeNhHAXkmgvG83CASwH+MS37sIVU/oD/jeC60bVwg
 AhYJmFtW6lHA+b5WGe/HJJWjLetKnjitOuWS/eOms3fYxuQnZejtDr+
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

SG2042 is not fully compatiable with SG2044,
So it is necessary to become independent const

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
index 66e54dedab140a167ad84c43f312f93af2bfa06a..1299097a210d5074cb23b644d4f102a2fb1a0e3a 100644
--- a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
@@ -16,10 +16,7 @@ properties:
   compatible:
     oneOf:
       - const: sophgo,sg2044-spifmc-nor
-      - items:
-          - enum:
-              - sophgo,sg2042-spifmc-nor
-          - const: sophgo,sg2044-spifmc-nor
+      - const: sophgo,sg2042-spifmc-nor
 
   reg:
     maxItems: 1

-- 
2.49.0


