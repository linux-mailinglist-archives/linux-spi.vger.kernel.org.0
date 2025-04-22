Return-Path: <linux-spi+bounces-7703-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40204A95C1D
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB323A4778
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC31DE4E7;
	Tue, 22 Apr 2025 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goekJWxH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810141DE4CD;
	Tue, 22 Apr 2025 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288854; cv=none; b=sFPVbsvUQ8E2w8Y7fD16rRWF7wfxYDLzpWAVPwelt88MVPV7lFOZ/AfLhq+qtHxC6XgBr7e1qvuD27Ojr6A/DqvZGEwpqsJerySygoBJ0uc3S10ncGlmwD7aBpIsOP903YMaw4raRyAGY2I5Vrbt8C7MfaKdC4q9uHhxuIHz+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288854; c=relaxed/simple;
	bh=ganoDYBx8hQBUMjZZ/y0o4Inc1qW5ojnaGmIwzuabG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=doFPbwcPX4gYtRGIH2vp6Hpt/E9yd0Va55JB/GwTG0+CnqBGaTBFWplulfKIUGchzismDaR0tSVxtoBhDIHKqS353IfJT1mt4bf1E/0C2THDFx+woV/sG8ReI+qUEGbzEhbXUrX1NtTh1NSOF4X3DFLJiNzWDwUFUpuoxrbWtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goekJWxH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224019ad9edso65249215ad.1;
        Mon, 21 Apr 2025 19:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745288852; x=1745893652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmODs/cciVwnwfJ66cvNDc8q3VvAdEuctjXNgr1Nt0E=;
        b=goekJWxHBDTNMupGd/2ks1b+J+juh/x100i5pc1dlrsMFSh2h9unMUhs9J8SCx7+K8
         OQWqYEHGOb29GgqnKycJviIXH1aim9ZS9dIV3YocBbmm4/DEyA2TtYfN3ESkt2DtGdYS
         vXl41OJ/u7I1vKlto3B9KT4S8MMujcPjpbflaa8g5Pt4Yx1wWzEtq7gOaRbdUjbuxSsp
         HrMVIvvbYtlh8OjxEJdYltfT/SJwsmZf+xVjUhhhXnpsVOi7l0P5TvBxfHSlceOxNEXB
         qSXP/epQuXx5fH5BJJldkVPlKdxjYOcD6PUJTT4qPaIzQF5O47uKNRr/2weplQ8kxtAk
         8MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745288852; x=1745893652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmODs/cciVwnwfJ66cvNDc8q3VvAdEuctjXNgr1Nt0E=;
        b=Uk21whuwIDhkGsgrqtA0zqbmc68y8WPiSms/vuGaF0/6EWFqyw62Ro90qARujiul0X
         pf/+KdIzkoQOzAh6L2evgHBqlOC7MWvJoLBKkdBMpjcVB8IKSKqt9Mpbrdq2fgDrcyyk
         UqOLLbZ/BGgJzipVfJ+AA+6NGZguVFc1Y5MWYgMoYxQ1er/2vmi5Ol/RRrhuQg/2ESf6
         BvFBaHRz8jbxNIhrAZEoJUZkMxAav4TAm4rM5LIq8vSWeuAyqhklb3HCflQVAV8AiSZv
         RKF31K/K1SUj8BWOX9ij0yvtbeh8KVM+tDnvown7YtNsxYV7iBKoLJ4whG8KNBWiR+kj
         LhgA==
X-Forwarded-Encrypted: i=1; AJvYcCUe6ksgdq45NMaWCk90Z5yQsejLRMFlKS5rSesiF4o0sBVcThcGoVMOTF40v8a3ltzb3qKjtYkJ83ElJnw=@vger.kernel.org, AJvYcCWsJ6YXufg6HB6HyARuecxBhR7BgDHVOvhtLkBUdty24nu5E6FwCUFzG6rvCcvXY0JUhxKQQl5ghqMG@vger.kernel.org, AJvYcCXtqVkw8epe635gKjXBYnfY41iVvjmRaSd3q4jwE5FTzJ1WFIGh9aw2iu0Vj5Taz01btvUTuNwS59+vCd89H9/scDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWOVzfa7lLd1YKLFuUFBgvGVU2wW9DVEZ37Nsqsr9UJfkBqyl
	ooP/1D0W57GFM05ps+Wz1FB0bdbrth7fh0f3kyqPDWMcva5dbfjDGOEPpcUMB46vBg==
X-Gm-Gg: ASbGnctt+cB2Il3I/TW9noEt8OMgafww03j4oMQv7Fj/n/EhW6Ar7xHPLrJTe/59f3B
	xoxZVg8GZJJpjTj56OJNQioTO+Ztp62AUHHR25p8XVq2rOo6S/HDeUlshG9p2zJeBg7cVXCKvO2
	RjlFbhOEfRx0S2jy9dyW5l6TjViGAm6hvzD4dHeLyUzAwAd+VPGcXGV4UVvzKQhsqIuPxTsJYRd
	53DY+1Dm296luW8n3l37pclaGNecFCbP48PGA85cfZcU9PLp7kEokTffC4SJpv+b2TJ9Lzpr34d
	FlwWViVdKmbv20ZRggjwshCOJI76EhYljYhMEipLJx7sHEd7
X-Google-Smtp-Source: AGHT+IGLEGWEeVyPyDR+wwWTFbq0oVcv8eF2ibjbH3ViryHv62o1TunCfyCqdUOPhJP1VvOrf1DOig==
X-Received: by 2002:a17:902:ea02:b0:224:c76:5e57 with SMTP id d9443c01a7336-22c53619897mr185730775ad.39.1745288851578;
        Mon, 21 Apr 2025 19:27:31 -0700 (PDT)
Received: from [127.0.0.1] ([101.76.241.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4ae9sm72962905ad.110.2025.04.21.19.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 19:27:31 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Tue, 22 Apr 2025 10:27:09 +0800
Subject: [PATCH v5 2/3] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for SOPHGO SG2042 SoC
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-sfg-spi-v5-2-c7f6554a94a0@gmail.com>
References: <20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com>
In-Reply-To: <20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org, linux-renesas-soc@vger.kernel.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745288836; l=1083;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=ganoDYBx8hQBUMjZZ/y0o4Inc1qW5ojnaGmIwzuabG4=;
 b=ipoA2Z8SVi5C+lrmIzQZEsdCe2VqC+YO7vejgCp0oqomBR+RosewWbUQDu9EyO5R73jjrQsnV
 ScUl6G8cP6eAca4dFz1Mq+0GcLEcRFNBG3vhZcGbnNpxNXGog9Dcj/D
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Sophgo SG2042 ships an SPI controller [1] compatible with the Synopsys
DW-SPI IP. Add SoC-specific compatible string and use the generic one
as fallback.

Link: https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/SPI.rst [1]

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index a43d2fb9942d85b1482a52782c0a97cd5c6edd99..d32380a2e5b18f61ed66715b4ac67c04fbda10ef 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -67,6 +67,7 @@ properties:
               - mscc,jaguar2-spi
               - renesas,rzn1-spi
               - thead,th1520-spi
+              - sophgo,sg2042-spi
           - const: snps,dw-apb-ssi
       - description: Intel Keem Bay SPI Controller
         const: intel,keembay-ssi

-- 
2.49.0


