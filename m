Return-Path: <linux-spi+bounces-3703-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C8A91DED6
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68917280EA3
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C3814291E;
	Mon,  1 Jul 2024 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKrGnrqo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1C60BBE;
	Mon,  1 Jul 2024 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836054; cv=none; b=NPUtYwNSheQIA7mrBTx4cKz9o4ZU0+OeWY6/ulndcPP9iPbzs9ybZkRHMVXnoQ2bkvTcvwvFJjpgxzJeoq0qtUb3S182GM4KaWzw4zW58MJVrsYPBZYqcbVBepcxnyVIUZVoNpPm+NNJWrBKM8T/I1D7g9Y8ED8XSHVons1c3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836054; c=relaxed/simple;
	bh=k33c+1GVFYpeNY3jrYaSHPzNC3OQWkhDcyLb+N62TIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eq/wnPOTeTegb9QS3N60gefIsBZTBydHRGXWQO5C2IYiXBCaIF8RyXzHRyha/BIODKoY96xqhMJZPnZl1B3qwfNsN83/J0cCz5t07Vn1DdeNpf5uIXose6sNEZ63rT5SuHOJM+gEKOwjN18z12pnTlkb5Y/mWVvaCi310UNxBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKrGnrqo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c81ce83715so2106887a91.3;
        Mon, 01 Jul 2024 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719836052; x=1720440852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Il8RvAivystWZIG0DojBlqOoWjix3gP4iIZXLpKwVH4=;
        b=NKrGnrqor24nTQ+s0zjZGduP3Tn8XKbYvD5XBuTWGXsoErocIExhNOBbdq0E8AXZCE
         jU7Id/9RZBGgKgL7oxqdpVMoroES8sMhIeVdYuu0/6P4luXluRG46JdsYJtKU3cIMdDC
         THeqnOfHcrur+Muq16J1yWBCjUYDpf/3q3p+LglmdwMuMutRldDcrvjeVLET/iH++2xw
         UhNH4aWcZqFfP2xbANGyHXvlpmIYHd4p/Ch31nGVCTyMyHLtmKCx+KrTLi14ppAcSisw
         yO8atYnc8ZH8eAV6VoOKlXlR1j6E3WT2XDhomVSWsklOaepZC5iONu1J3cDs4MWvUXaB
         ZPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836052; x=1720440852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il8RvAivystWZIG0DojBlqOoWjix3gP4iIZXLpKwVH4=;
        b=YKktkBGvEL1Pf8gJgm6KjbBCjhATTpyPs2qrtIkKuglMY/2aM3lGvjjKYIEsWMpApi
         +SXFzjnQ6VBNFuFVV5oHu0eW1oYyw0G6lbkqiX0tOhbOABYBsUuNfVTulhoatfuDooz2
         nUsPFOy2f21hfsF8TC+05QAHHCbb2Tj/G4T5Hsbpih4W3fb/LO5MJ7un50ypXgMC+mlM
         HbznFSOSBKv3mkvUeVDwMv1c697LZTESA2dNn+pDIPIFdmEsVTYOnxl6el9iR5MtMJtv
         PRSbNrjiDB5OY1uv1YoXmn3pJSrbicfDLNIO/3/C2BL5Lhu9LzXFr8Z9GoZbifHSpn1t
         MCCA==
X-Forwarded-Encrypted: i=1; AJvYcCWBIRalqTqmVzTCiFHJKMg3y6Ffmf3+k6j7d5TLvIMAMDzicA392cdR2UyrfXhiN0R4POpbwnP9S/JfFPhq0aPrjzdtTiJyyoWsEILI45RpqTAiHE3zIWNddvxRkpiBy0UQ3vd74BjyRC4ol2kxIB/VBdEZEyjz2lENB5aUHBpQNgIrzQ==
X-Gm-Message-State: AOJu0YzsAuaD37W4UTkUb2iq2hhWVsU7zPN5vHCq4asV8e/M53pKXYdw
	UqRe423CJS+J2KE2WzVr7bmMu7/kAR9MlnVSs2MyHR23EMwSBgF1
X-Google-Smtp-Source: AGHT+IHs8mCU7JTsODYLCtCH8cGJqwnp47JeXfiA6d2spp0vsMSWOcIJ61nbGfWMfVqbr1aqe1wgnw==
X-Received: by 2002:a17:90b:19d4:b0:2c8:5bd3:551a with SMTP id 98e67ed59e1d1-2c93d76512emr4212533a91.35.1719836052174;
        Mon, 01 Jul 2024 05:14:12 -0700 (PDT)
Received: from ga401ii.. ([223.178.83.109])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a77sm6613098a91.6.2024.07.01.05.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:14:11 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] Add basic SPI support on TH1520
Date: Mon,  1 Jul 2024 17:43:51 +0530
Message-ID: <20240701121355.262259-2-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implemented basic SPI support for TH1520 SoC. There are two SPIs reserved
on the LicheePi4A, one on the SPI Flash pads that are blanked out on the
back, and one on the pins. I implemented the one connected to the pad.

It is using a fixed clock of 396MHz. The address and clock frequency was
referenced from the TH1520 System Reference Manual [1].

I have tested this on the LicheePi4A.

Changes made in v2:
- Changed from single patch file to a patchset by splitting the single
commit into dt-bindings, driver and the devicetree.

[1] https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf

Kanak Shilledar (3):
  dt-bindings: spi: snps,dw-apb-ssi.yaml: update compatible property
  spi: dw-mmio: update dw_spi_mmio_of_match struct with thead
  riscv: dts: thead: add basic spi node

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml |  4 ++++
 .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
 .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts |  5 +++++
 arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
 drivers/spi/spi-dw-mmio.c                        |  1 +
 6 files changed, 39 insertions(+)


base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
-- 
2.45.2


