Return-Path: <linux-spi+bounces-11544-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B87C873F6
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 22:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 259224E180F
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5384A27FD6E;
	Tue, 25 Nov 2025 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay1RJdVh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8D1A23B9
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107138; cv=none; b=rNNArmgoj0sb5OSfS/ee2ENPohBqaOYYG5n7W7akuhWB+poxswJpvSN2SitoSYz2/B2tkpYNg/i0zwWHNRLO+ocdSsgc9RiHThHwiiI9VJZMnyjrW7xKSVsFP8QVLKT3xyHmi1N0dYIdJIsYXN0+5mUWSrhdsgLtq3uhv2oGdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107138; c=relaxed/simple;
	bh=VlxfKwb6drAkJYTHHriEjc7I47o3xKGHFN4xlLeNgxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhF5Fp4hPjTZmTihr4M+gP1IaYadcQlzYWXFz3LvKv7S3R9zOKXTI2ZoE7smnP4R9fXNIfqxcoRpTr3N25V6mine4L+4PECiJzbRAncBtyv/3U1lT4CiFA9HFVoIbuITCjTT0XOHJjIeV3Dh0hRCMmYdohIqO/zcMM04ptQL5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay1RJdVh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c4c65485so4822801f8f.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 13:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764107135; x=1764711935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L975bxm4Gx+EyVsxiE9RIjBJmcCJrfpso+xG2/B2N9A=;
        b=Ay1RJdVhEsspO+prwIyjrpgiHK2s1wPYvnloOMgX6XOPe7fy6qJFtFqAN5jXO8WtYJ
         6QluPnnBWnEXFkgB1dDGzHA0Z13Pppdsr8QRnEeTOAWPLKv25JFddMYQcJf29Jm89esm
         3ho3YTDKJ8h3A6uQxZig11zkmL5lU8SWp6+4DCKAxCbvmV+2jBDvKg21VZZ1skl6iQ7a
         PnI9T4NCoX0oGpq/m//FPx+F86yYHXL876c7RYXkLmCeE8nLd209gUbT8qGxepiLqF0Z
         OQde3riNDCucqZKsx8gQU8ovkKILq1n85oJpMvDHI41qKCYZ3tiTkqFPiJXg8RGGN8ZO
         dZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764107135; x=1764711935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L975bxm4Gx+EyVsxiE9RIjBJmcCJrfpso+xG2/B2N9A=;
        b=R/6lFoQbRK8c46dwsLeFavmB8RRlzJqWqikxXNRhZPfJSWl04Z4awqi0LJDKSxo7cS
         erNopT3b5Nt4QNpgxG5tt239Khi2uBtk9OpuD0BZyDVnWVPWLxt+7M0B+XKZLhtPpw1j
         XrVeXTHj/G/Dr4icGOKr7ybLY9p06CzzJ8Dx4c+lPFL+lDM/ghCjcC6fM11BUkKl0q+Y
         XpZl/Y/PL6d2+bss17PZlOJuDZjMY9+M0RYrFQxdsn/+i3qIeBGOzh7VV1kW1skuGV/D
         ToF+lLVqvQXLzYCdqJTvXB0B0wBATrYCjUHinfjg7lfKvxB+sENuhpFzPq9TxmWNUE8d
         70pw==
X-Gm-Message-State: AOJu0Ywj+MzKl8BNb0FU6mF1yYiLxbqOKncDmcPupbKr1I8IZvnkJHM3
	gdvs+ijknFI57ltQpXYgnO0z8Ig8UM5sHQhzMNARsXMl47ibT+a5peEz
X-Gm-Gg: ASbGncu7qRR//2Z8nv12trYRNKcGXNj5hTQOpia9FVDUpchdnJQgU4hQ1kCZjE1lIB3
	2/ZJ8UTXbg0HHFBG0GbTexWA+qVHU0ZJ6HhlNfqyGUYF4t4YWnZX5+QStcU0WP5Y0DGOg47n4KJ
	4v60vat+hTMC2rm3BuPqMNljbUOxqCL7V9oD7k00pm0h5x1Hm03a6xI2qyOU23vpYz7W7EhfFBn
	ahTgxsphOtOOlfJZspFSRy3xqwFjLqBybGgZtmEWYAt+4C0ZUtGHstXsxEFJEzwV9pVWqaseNTh
	WgO4EuOYQP1rMNAcLYxUMqwUh6j2MVk7Z/u8dkBYzsa/O5+9zXVbzGM/dY3FTEVLbovOLsv9StO
	eFmLEsriiZef7ABHAK94uVCap6IWeCUHOTKyISNWbH733v7c1MTcSgbpld48ESIL4k7+koa06j7
	yzH8egtH1GOMiTimhLs0+ZQmIsp89hiocIcA==
X-Google-Smtp-Source: AGHT+IEYQySQcwxUg9tDkdvcawtVF/nhiWKoBYOu7uxaLo4Nkvt6XZX9uPHdB9ZyxPvEO3tkQ2/oag==
X-Received: by 2002:a05:6000:61e:b0:429:c617:a32f with SMTP id ffacd0b85a97d-42cc1d51a63mr16565265f8f.52.1764107134970;
        Tue, 25 Nov 2025 13:45:34 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:325:d7d3:d337:f08b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e432sm35494596f8f.9.2025.11.25.13.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 13:45:34 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/V2N SoC support
Date: Tue, 25 Nov 2025 21:45:29 +0000
Message-ID: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
compatible with the RSPI implementation found on the RZ/V2H(P) family.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index be62fd0841aa..5f2672625c30 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -12,6 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: renesas,r9a09g056-rspi # RZ/V2N
+          - const: renesas,r9a09g057-rspi
       - enum:
           - renesas,r9a09g057-rspi # RZ/V2H(P)
           - renesas,r9a09g077-rspi # RZ/T2H
-- 
2.52.0


