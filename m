Return-Path: <linux-spi+bounces-7752-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361F8A9BCD9
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 04:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6B0923A42
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 02:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA36158538;
	Fri, 25 Apr 2025 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7SFccOv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C159156F20;
	Fri, 25 Apr 2025 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548131; cv=none; b=JiV5Z4qsn/f2w9r+p6l316xJf6qNP9ECadxd+1cdEYAZxPZkcPE+GeCPuNotRK0skQmbQvfCvRfHMBLvJjEMXjpwJOpWRZt47mZncnveGjcOuI1xY8Oj7+/lXncz+SeQjrJ2xtvSJFNctKrkRHKt+PeLCzzhYs4xuH6lOk4TMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548131; c=relaxed/simple;
	bh=ZmdPpnOZ86WV8AspiWmmzZXwyUoSGbTCqeZlZB1Dz/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kr7fdcWSucjw8e876MI9zcrXnJ56Vd5AXUDB4gsf48aYadbLiqXFXYTNUDW3plliTrYdhEYQCtTor7NQz+g04JrePcgSPMg+JAgmrl1sjrtiPYB1GV7fNEqZqRosumJr+w5C5bYH2ljLCODmTQukIW+mrNPBSAIfwiYkWttnLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7SFccOv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb3so1886013a91.1;
        Thu, 24 Apr 2025 19:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745548129; x=1746152929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hpF1QYIR1QzmtFMnUvu7JqtGDUe3J84yW7wA0AOB8M=;
        b=D7SFccOvQByHt5hAMvZSwlbpH5X3kZV8Ymb5W6LhThrq4FfMGSVsrlIdXww9LzOMQR
         YflFC9+wIw2LM9MMx/dRL+BBE6QWgFPeBjlIoEeu8ktVamXQCA1n8u5eEcKaa1bmQPd6
         eSK58Yiy4hovgw7MMyzeehfN8h5yZP8qSEgwWJzFgRhll2piwArZ4IYllRLxB9n+vvAt
         jgw8myLXkFZGszUwj/fmwjMIqoUX8wBECg0JqmfyAmdY6Scbu66ckoq5G9Gu0S9GKc1W
         DavRVIVx8tP1mneHcVK0/kPXP0cjZxwv5Szy0Qoqw1TNnzTKmfMTWzXtpgWOIU2p7FJg
         DIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745548129; x=1746152929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hpF1QYIR1QzmtFMnUvu7JqtGDUe3J84yW7wA0AOB8M=;
        b=uYZIIVBp/u0rb9isDvGQTOR/f9AwoB0Jo+xgS/5J8KdFl8KWSwYEGKzrojUg7Ybxkr
         KlkXNwOm3B+GOhXy3yimb7E9mYG3GzmAy3AYkuXJfEegueptnVM96N4JamTovCaUploz
         3/fiOveB8l6sCRjsj4vK7g8nNwHCUhZzI3MOZaD6tl1Qr0mHsSrt4CMajn62M7w4wpTf
         HIa9dnBlvmw2jO7UruKDBRaMxoKKFc+LpNqfvxOiF97rcB5vRtmJSW6ocOheHaupA37d
         mpGxV876WVBG0FLUiecpJGyklOZGZwVAqbvYnLFDWzD6KhrcgokLkyqBs6jj60nkxlMu
         eXCg==
X-Forwarded-Encrypted: i=1; AJvYcCW5yM5+iL915CcGMZCf3O07MMnHfzLh4lZyg57176nXuYuqKMwmsh+W1nWVb1o8t+MJeuPEfvj5WXQ/38o=@vger.kernel.org, AJvYcCWKeInpt2BK15XIpteLdNhj0cnUDA2NeKtzPBbkV0hFdRCqb9dnVDGhKMBngoXjK5HQPDds5zWbnxoZ5gdXdl4g1E4=@vger.kernel.org, AJvYcCWZ9ODeHB2TDnL3FYHIajnOO2Xr+Jvhh629C7ugaKHJbWJk96+LrcPTWYH4RGs8a4bC4WrcewkrX+P3@vger.kernel.org
X-Gm-Message-State: AOJu0YySA4B+ShvosR7KGDIm62jj+2EEMtTD1Fh0mias+2lBB0uJjRz8
	UVr6hkHEvnYgIEaJGCrIqlpFIlYDcgZjdrba6XwF6QNmXgsoScLZLZah6LGSHeQ=
X-Gm-Gg: ASbGncs6A7dKwDE7JQMfUm/pR55O44LTR/oV7PBCM4fEsOtJPO7pUKaMiAct6VMAJCx
	fiizcNr9t0+lZKcWASrRrHUyh1UsPWNc9dGLvfKCsvMSchfVsJmwCKZy9thcsmOCyDh6UO3dnSS
	eYZVIF7nNEOgpX6hQ7Blb2RcymkVyZDDI1Rzbt+whDbU/hizAVfcWK9NZUUs83NWI5Uu42q7b7c
	wB4Q2OnleIvCe2lX9gndZIf5eoVf1ow3IAx3ntwtRFuvp24oqXsEgrET5HQIyNBwcml4SBA/isE
	CzyDfUPUgmd4nKw1v0v2KGXRBvf6ZJOibFc/5X1HXdwPbg==
X-Google-Smtp-Source: AGHT+IHhVh8/syiqQVm+l1KSae9zd6leTCYEp4C8rAUy2J15yHjmcGB7QJ+GZArGfhW+Imf3+BiCzQ==
X-Received: by 2002:a17:90b:2545:b0:2ff:6608:78cd with SMTP id 98e67ed59e1d1-309f7ddfec7mr1289140a91.9.1745548128840;
        Thu, 24 Apr 2025 19:28:48 -0700 (PDT)
Received: from [127.0.0.1] ([223.80.110.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f782d4a9sm365455a91.30.2025.04.24.19.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 19:28:48 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Fri, 25 Apr 2025 10:28:13 +0800
Subject: [PATCH v6 2/3] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for SOPHGO SG2042 SoC
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-sfg-spi-v6-2-2dbe7bb46013@gmail.com>
References: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
In-Reply-To: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745548101; l=1082;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=ZmdPpnOZ86WV8AspiWmmzZXwyUoSGbTCqeZlZB1Dz/w=;
 b=gxD0ZGLEmhTB+UWLpRrBTOWrtsQ4OIQo4V7QCfO3+5juR/uiw842tItKKNNYO/cvyov+2Qhfd
 MmIQ/Uc6t0qDmYKN7Rmv47ERGvbISoFG18X+1DmWMDmxE6RYENOJLWT
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
index a43d2fb9942d85b1482a52782c0a97cd5c6edd99..53d00ca643b318a8e75b9b79dbc6bf63962fc3be 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -66,6 +66,7 @@ properties:
               - mscc,ocelot-spi
               - mscc,jaguar2-spi
               - renesas,rzn1-spi
+              - sophgo,sg2042-spi
               - thead,th1520-spi
           - const: snps,dw-apb-ssi
       - description: Intel Keem Bay SPI Controller

-- 
2.49.0


