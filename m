Return-Path: <linux-spi+bounces-7406-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC89A7D445
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 08:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F4916FED0
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 06:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B722541C;
	Mon,  7 Apr 2025 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzCujVmt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E62253FF;
	Mon,  7 Apr 2025 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007726; cv=none; b=erwCfOQ5C/GZzvyMbL1JD+0+r4omz0JM8vH6de8cOrZap7Y7G50uo1LQkWBq5M57401KyqpB0VVjwLa1ylMYvgR7G8Gxrr/FeO3ZOZRTnkTygrux5OG5uA/in3zc5j5wfozp4pwLVD5DzYgE5U8dgnJ98tagi54RZuny98FfjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007726; c=relaxed/simple;
	bh=Ocz7+gcKVvx9JS7ROJOowK4HkGeQFJNuw93TvrjIVTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVjgR3G6p8eZUK7ue8BwqF//kV4HuMXI9oBIjUqFqMf6Io/vIb41PQ8ncE7MWm93O3mpYA4ZD7ooYKJpEZyMDg3AUzbBEcJ4ufkw8BBmT258A+41tNv6xGoH4gKSaW0Vi+LDZwOctsfw3QfdRLZJUpqIfozPM6xHM4dN6PXHjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzCujVmt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301e05b90caso3759107a91.2;
        Sun, 06 Apr 2025 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744007724; x=1744612524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGIQTeSUJ/msyOcBGgyCOEy8RB/Vu85gn7KiLYCFQmg=;
        b=PzCujVmt+Wu0e+e9e3pDOlx4PKjGChyO2lKUa74ku14vdWgeu5U2GDFXKjiYzNqHfv
         0OPmw3aBZw0Rzgb4Z3sHnnm8aQ8sDyYfKVo44eG/14LmDQvn5fXnskPK1Kzqq250XB2i
         w1IhDw/4ZtnVYlcjWdr23xGcAou7otVi2QoEhBiLF/X3MSkxN8IsVJKrs2xQ0gn8SVzn
         OObhMlp6vhdBCFo9u+/RY+N6pxgVUwLmo1eNhPznQNFiuHJ4jl7+WhXmoRVMJs/rx4W3
         AsS6zqXm+5wYyRwGPjcUPIZlIRPEa+n4tNmUavePgEGrCIZP9wQqhyeuZg8zPfFBSOrl
         yBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744007724; x=1744612524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGIQTeSUJ/msyOcBGgyCOEy8RB/Vu85gn7KiLYCFQmg=;
        b=G1UNGXSbfwDXNnKkYSoXUqcmfWY+pkL2FoZteLL7WQdMy5Kp7jU07pRZc+25Lr/jvC
         8KiDPOEGT+EDJ5ASkjQ4Mv7c0IxpVNInmpgsOO/1xphTLh2zEIZGh12RKgZz8nd2JE84
         MA2ctZH+0H8TUauznCWt6Ndgyvw4H5mQFvpfj/3bPq2S8Z+Z3sQpwlE0d3WMbe43pVis
         husRcHgUMJnNgOj86knV3+9GjslZnB0jKkQMoPjWsywLYegFsKnsIGJeo67C2dgKdU0n
         hCF1CU5hFopChUPR7rCNFJ2WSuLzJ/p25bpVFVSKmCw3XYB8Kg8EkHlrhFSB2ctE5BHX
         ojkg==
X-Forwarded-Encrypted: i=1; AJvYcCUC8Pts3JZa9X9u/bSvTwrtWDzf3y+1dup7PuYCPx3E37LupOms65d7adawhvwBNjNpUPtKnC8XE/3YXUY=@vger.kernel.org, AJvYcCUIpQrm3znD/TITyvCWPzSvED0bCTf1PBSzqNLsvLD2vTMwS9Yw4CZA8Ckx51gQUU1ZIpddAoZFVDmz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/2YrBcEa/PHyueZYKTcGd4t7+xdGZpfn3w0wXe+1q4oTU1JZ
	Ki1foNnR5yzWdWiJA4wo6LcVQtouOzFnS5xK8fa9puqjACl0HtOo
X-Gm-Gg: ASbGnct6qzrMDBV88bygvquD8Ct33wngV6kbc3aMWKKUT9Q+hs+GmkAxY4yI/WOLIWM
	tWpj+iZuk8ShD7ZvQHH1vhgotQVbEq/DaaziAe3l6daEoXXvGWZMJWlTMDoTe5zps7RSJKz1RVQ
	DsO+8cNrOzZQ7sDlW1TgCPX9Hphuf8c1iSj6b5dMlOwj0MgkXyDwh1aQfzH7CsR6iQpgZgLIw10
	OQfjQ24kZ7HUCUO5HgBoV3pGg6nRdOZgNczWQJyV8Dw9/pDk2xKVWOGO3+6jbY5vkwpSWTC1NPw
	mgDvpFbR7PVaKx0DAoxWMQX+t3TwOi1M+KEy
X-Google-Smtp-Source: AGHT+IHBFpIgTbEaMnBWm5RVBjeYevVuixu+5yTWxBRjJdtCoVEVF/pCoi2mcsaK29zligKIYWm+4w==
X-Received: by 2002:a17:90b:1f8c:b0:2ff:52e1:c49f with SMTP id 98e67ed59e1d1-306a4892fafmr14203035a91.26.1744007723635;
        Sun, 06 Apr 2025 23:35:23 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::610c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983da691sm8048044a91.47.2025.04.06.23.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 23:35:23 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Mon, 07 Apr 2025 14:35:12 +0800
Subject: [PATCH v4 1/2] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for SOPHGO SG2042 SoC
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-sfg-spi-v4-1-30ac949a1e35@gmail.com>
References: <20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com>
In-Reply-To: <20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744007713; l=1084;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=Ocz7+gcKVvx9JS7ROJOowK4HkGeQFJNuw93TvrjIVTM=;
 b=Uxcj0G45ieTZvKKQjyJrxTtDAyr9bek1RVrok389pH1B68f9abGhumzllp68p4QUAXIPiL0cU
 w83qtuBizUND2pqbvQGlxfR9NsMTPYVLoZS9AoWD/VKGhB/9V9nGlcB
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

add compatible property to include "sophgo,sg2042-spi" for
the SOPHGO SG2042 SoC SPI Controller.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index bccd00a1ddd0ad92b437eed5b525a6ea1963db57..94102d94ed5dffe889a8a11c1c637d466713c208 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -88,6 +88,10 @@ properties:
               - renesas,r9a06g032-spi # RZ/N1D
               - renesas,r9a06g033-spi # RZ/N1S
           - const: renesas,rzn1-spi   # RZ/N1
+      - description: SOPHGO SG2042 SoC SPI Controller
+        items:
+          - const: sophgo,sg2042-spi
+          - const: snps,dw-apb-ssi
       - description: T-HEAD TH1520 SoC SPI Controller
         items:
           - const: thead,th1520-spi

-- 
2.49.0


