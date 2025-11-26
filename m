Return-Path: <linux-spi+bounces-11600-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF909C89F5C
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 14:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F5504E41EB
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D92F0C66;
	Wed, 26 Nov 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6ayN38z"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A192EF67F
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163002; cv=none; b=TkLarTGyf+lqGJmGw/C+XbAIIuC1IGMGmaYEkLFjajJl24BYLN+c0cOKVKAi+h1BaM4WnedNosffh8EFvtLwUvTxEPf5E9jpusI2gWrCasOpIc3igDxtGgrOSQdK0yH0ACekEL2uenkBYDJD2TalixcJ1ritt8DKgPnurtA1m+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163002; c=relaxed/simple;
	bh=faWv1BKLwmgrRhsFbzM0nSUy4lZJQpHt6weQy1mt2AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9+6BsztwhgKA3Gq3ZoD3+VJxE9JybuXp4G5lELfhD6ua0iJAnPfH0uEwqKxhxKz1q/gv+voiGZcvLWqe8VuWrP+YOHsWrpqsX+wDpSTbt46KDpVEJ9BMp0oM/ZtyqO2VzobyOCuBbHV3ELREZ+k3WvSmm+OtZkricqeQBPqUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6ayN38z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47774d3536dso7291505e9.0
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 05:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764162999; x=1764767799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dc20KpcKGsyBbwnSDgDryYseKZ1HNwXdU9KURNVAeLQ=;
        b=b6ayN38zcsyyx2qqMFhIaFNK8rj+NmbTd9+ya2o4eeExRN8c71MGgcCqC4yTk8N9uq
         SERAiD4vE6DdZjKFmXlwMJPezhuKwfNL2HE90bo3mqrbw9Smg7H8rMtiZGfvgx87bB7L
         DsiqX1nHVZUOmIp5xfaNGPU0LDwbS6cce5xpYdfghcI5n4H5rUqZ6zDgfEirw0VJIngB
         XlMPdEC2dM8n4soT0FCSt0hWpgGWsvu69Cv9DAb+sa1wqYkOy8k8yhmiu0AunqHlCTbB
         WyJA+eq/1nmsADdD5nQpkmZJkfFlC+8TghlN7HIShOQ9rfw1JABU6c0uHKWKKakv2YL7
         dR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162999; x=1764767799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc20KpcKGsyBbwnSDgDryYseKZ1HNwXdU9KURNVAeLQ=;
        b=LnJzSN9lmKopdaoAPIuV3M25eTVPIVM5CrVdNKRqDt88+Y/GSSeoPRmR0i0fojjzQD
         BaXZKEcj6gz5d/lUxo7jJrBvfCzp9RVJOMA/nfEw4TIixBoZDbw1uMGMYMs6Xu5aQu54
         z1bfEtPvglrxaMS8h8jwn391SwoOHnvXPdWLQdPI65vABvQWcJfUmj7lqV5kqJRRauoQ
         jVCUUWpJ0fSKC1KGodBpcBt1PH1qTapytKFc8IgW3l8XfU8neHaI4cnh33V9Op9NzYha
         kn1UiuzRpED8EdR0g4zRUdaREke3m9defZMe5tFiXlEuP06ynOVH69iNWGvhZiLqRtas
         SNRA==
X-Gm-Message-State: AOJu0Yz7ysFmxvxGnuQqSqE38qcbJ3569ZxUONm2Gi8oUnG/ztiNaVvT
	zFS+n0A0bEvf2Y7njOCflnY8r5TUEP1Fe1PaDfHzFpQbCKhH1WnlVx3a
X-Gm-Gg: ASbGnctpxyNjgdVR+AV98ojwzM+nHYVAaLbVNfhCdPb1QhvXFmQnSFxRSl0wbnRHRQV
	AnSZ1ggAW9vzXCDFNUuX0mI9tdrzjVAbv9fUT2YyBW8/rdDDiFZX9o1frA7xaiOQ+kdM/fVwTBs
	kN7G1daMMG3flpqjepW0xru9EJPGiIeKcdJCIzpM/1jU1E16+szKtQB5P02dgslw7FUVDNCGLOF
	oa/qTz5lGP4/ju4dMcfsPNIjahw9x6TjLgCGmqOU1UBA0+r0imc3yxqalFJbI3Bwueh/J9d/C14
	kKH0hRu9j79uWA6anI0DClP3DKLdJcx+8UwDy0UfOJ02Ie+b75XWSLfUa9PMKo0oyDwzyWEaudi
	hZBoTQ66eDhh0p3BoZf+OvEaH8wG2AAGn4jY24r0UAaH034W6IFHxZAFhVvyykHIi+yTK7/Nj1l
	6aSLxt96vCxLn4Cfrp4KPVKUPJfyL9k0irk9XWjVlfpWpz
X-Google-Smtp-Source: AGHT+IHGVgsex1aozh3uavACEdd6jeuHUy0ja4ZwFhFW6QS6OThl3MSD7NtoCvVd0LZvrzgAMxoBaA==
X-Received: by 2002:a05:600c:4b19:b0:477:a53c:8ca1 with SMTP id 5b1f17b1804b1-477b9ef5131mr158874325e9.14.1764162998946;
        Wed, 26 Nov 2025 05:16:38 -0800 (PST)
Received: from iku.example.org ([2a06:5906:61b:2d00:1f84:8744:5581:e00a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040d3c72sm44142985e9.6.2025.11.26.05.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:16:38 -0800 (PST)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support
Date: Wed, 26 Nov 2025 13:16:19 +0000
Message-ID: <20251126131619.136605-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1-v2:
- Added the item after enum for RZ/V2H and RZ/T2H as suggested by Geert.
- Updated the commit header to match with the subsystem naming conventions.
- Added Reviewed-by and Acked-by tags.
---
 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index be62fd0841aa..0253c04c28cb 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -15,6 +15,9 @@ properties:
       - enum:
           - renesas,r9a09g057-rspi # RZ/V2H(P)
           - renesas,r9a09g077-rspi # RZ/T2H
+      - items:
+          - const: renesas,r9a09g056-rspi # RZ/V2N
+          - const: renesas,r9a09g057-rspi
       - items:
           - const: renesas,r9a09g087-rspi # RZ/N2H
           - const: renesas,r9a09g077-rspi # RZ/T2H
-- 
2.52.0


