Return-Path: <linux-spi+bounces-7011-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498EDA4D698
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 09:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF307A5C04
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813401FBE89;
	Tue,  4 Mar 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC7uUNj2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072991FAC4B;
	Tue,  4 Mar 2025 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077385; cv=none; b=ppflcwZ0SWIMV8r3r/hPuyberx7D88a2ZAzo0xzfpqJ24fsrQbR+tVPzlP+zt28v5kek379FaYn2d+Nz+Jv1ueP6X2A99rTUgUcaSOjaUDa/S7EJ21N4OdN62CjkvPJxn17d4v4eex06nqcgJV6eQx7dUV1z12r0tTW9DnfQxOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077385; c=relaxed/simple;
	bh=JlScFjY8QWH6alV3B7iC/P9dMhJjSb4OnuXww/4RGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIQQQ69l2Cei6YqsJ9NN81S8aD3swMuLtl9ePofsDcegBLFS8mSEvbDZdprauAGjBX5d2sUU1+X/767u+pGzL+ng8u4bu43yz9nfeorG8SivV/Cyqf2S/2zYkF8yZ+EoSRnbw+aDnBtX3IHHvm1yyucmlWPQ7m0tht9QzVE9vSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC7uUNj2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239f8646f6so44781195ad.2;
        Tue, 04 Mar 2025 00:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741077383; x=1741682183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UoXbxXKgyk87JlDdAMTtGXs2RE6Oglf8lNp5fJA+vrg=;
        b=FC7uUNj29k0xnR7l9ay5C4NQzfTQN8lASRFB/HV/Te+SlFVju1zRARrzSRbWn7ld/O
         0I5hNELJ5tqF+mtUTFPBvqIZxHVLbUpsj/7pgm3mjrQ2At3OqwCnlt6EPljK2L4FV8aC
         VzxITzKPTfOXwnPMHOCRFlJVI4a2iJcEjHvVCwCI9KhZELey3ZPz8FiIHEj8qlDpI7+f
         iLl3MdudTuqHm6DPXxtZwoFkul3SklSeY+kXWhWeh0vaeJsfzFcqDTSW9poAKC9PH7Kg
         jfB/1r9m0EaHYVotjsE+GhqpQsrj/SsNMOdBHf0+CA/uBpHdB9iL7EX2Zz8rU5xhkOcH
         stWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077383; x=1741682183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoXbxXKgyk87JlDdAMTtGXs2RE6Oglf8lNp5fJA+vrg=;
        b=K45Hx+zih8D/p3cYC2fJTP4Lpd+GfrJeK972CCKPW1YVCXBxnx6sIShvc4xCGvslVc
         vM4OjImoXUKJii85FJ9Q4szyFSl5RD4t7EGfvyjRe5pWYUFfx9NmA5NYiw1mb+PjGTU1
         O7DZ0g6sxSbtaoqodgoBYd0wJs5Mcdn8d16DIp/NHtW/Opq6pVCnv+EvDY4vBkgRIvQM
         SnXyubsQAP8ieQ5XLx+0IAOGyf+Vbd6J3EJGGfR2vMKGHZIinOhlcNsf2OxsiaTw9AT0
         zUlv4dbB+BsqzrsmWyndwiRzjMG8fbfqtad7S45MRGQO1FJMZoNme3+3b2aGj+sjKYHW
         Ph7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3u+lh7nmLpEm6FmguOvHB+Rcs0KE6uKWhZjzp7Y137NKh5Kifek9NmRSvgtPvU9Cxb6Jb3YhTHTpF@vger.kernel.org, AJvYcCWZgL7HTRO++XoH9PM3XVIrYs45ee/7Axs4RzzH+eE5C0mOB/Fy7fDPcMHAaux9vpwp+8vpK/Xr9iXe3c/z@vger.kernel.org, AJvYcCWiHhZbTv0GwPTVFMNzL4MX1udcrmsmnj0L1jmHeJ3lQgxVlwQUS9KL4HvxLMxSr0emJXmYLam+Bjcb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jqpfG6asAMcBMqDKmslkLwdsVge15mxJvzRBlTskVT1qoEpe
	TfxQWKKK8p2I2iXRUiC/NrZUAmaXXKle4IksE52SqedKLA2jYnP9
X-Gm-Gg: ASbGncsur9jrdrDFOxagdUlAMJxeUzSVlFX2HVbv6AP2W6yH9wjkMWz/euLfhY4ldOd
	HKukAhqrGkQDx1x7LolF10x1vLGa5vWb7s/rLt1Ri6n7hLc5rOpMNGVDZk/J3huR0HEnagM+ZSW
	qT5Kcg7Dl+BE10AyUIcj9eKAoDATfbqk1vpLlq6ApPNpri1zQgGk2AgB61V92Tx/9Z7Is0Pslfu
	762+cruIK8BaRUcdhbiFeyCuahc4xByve4gqFxtbrYLUmMF7Ii6QkyEph6MdxFpxvwABfJMDNBy
	rkufNS8vmSwyziLocyY7jVCsGFb+tlhjCr8j//A=
X-Google-Smtp-Source: AGHT+IHftL+KBeXBmrscPavFmNZrOosSLvGSCAflYbLbvZZUp4Q0oBIUi+ZQvunyvSVmM/kyQ7jFFA==
X-Received: by 2002:a17:902:d2cb:b0:223:6747:f82b with SMTP id d9443c01a7336-22368f7b57dmr221738015ad.13.1741077382988;
        Tue, 04 Mar 2025 00:36:22 -0800 (PST)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc3b7sm90597735ad.173.2025.03.04.00.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:36:22 -0800 (PST)
From: Longbin Li <looong.bin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH v2 0/2] spi: sophgo: add Sophgo SPI NOR controller driver
Date: Tue,  4 Mar 2025 16:35:41 +0800
Message-ID: <20250304083548.10101-1-looong.bin@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPI NOR driver for Sophgo, including read, write operations.
This driver is only suitable for NOR flash.

---

Changes in v2:

  Fixed following issues as per comments from Yixun Lan, Chen Wang, Inochi Amaoto, thanks.

  - Replaced "sophgo" to "sg2044" to avoid conflicts with other drivers.
  - Improve driver code:
    - Improve coding style.
    - Removed the [PATCH 3/3] in previous submission that based on the baseline not submitted.
    - Added error handler to destroy mutex if probe fail.

Changes in v1:
  You can simply review or test the patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/20250224101213.26003-1-looong.bin@gmail.com/ [1]
---

Longbin Li (2):
  dt-bindings: spi: add SG2044 SPI NOR controller driver
  spi: sophgo: add SG2044 SPI NOR controller driver

 .../bindings/spi/spi-sg2044-nor.yaml          |  52 ++
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-sg2044-nor.c                  | 500 ++++++++++++++++++
 4 files changed, 562 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
 create mode 100644 drivers/spi/spi-sg2044-nor.c

--
2.48.1

