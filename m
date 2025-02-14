Return-Path: <linux-spi+bounces-6819-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD9A355CB
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 05:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43F616C18F
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 04:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6B185B72;
	Fri, 14 Feb 2025 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbciuQe8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED917557C;
	Fri, 14 Feb 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739507642; cv=none; b=TS9g1yaGjZZb/+m5CwNaT7aDj+kH0WwkPfhZN2IyZP8Y6D4qmcg9xEjjpHl5PF77uz+w4pGH8Zb2TB8dOiX7/HZO+kBhwivJSBLoUarJoz3n+gi5Up3MveREPdKdPw/+pVAJy9N0D85WBbJe8TOOOqoONwAU7p1fl/whQQxcPh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739507642; c=relaxed/simple;
	bh=04ewGkfCnt4dGtPWuETy+xnmdSoDM6RaH0T1s0ZJ1RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSwVdJCuZEbg7q706XoxPdNhQN5A53unqYGWLsAO+vB3Was1JZXgHDdVjybyEju7aDzz5ahSLYT0nr1bn97HdgCxlDyXKEM/OY6pjLGyggYAUEM75hwc7LfkNgb3Qc8WfHlBDzqPMAiv2aQAuCj3zKpAV4429Fcd/FdLrCXTE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbciuQe8; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-520349fc3ddso536828e0c.1;
        Thu, 13 Feb 2025 20:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739507640; x=1740112440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS5Knb7XMjcuFKIBATQ7nHoTfU5um3mKBC4QXOJc2lY=;
        b=cbciuQe8EeockW77yIcNwELtXWgmso8cACC+4MJ7USRRRNs7/5N2pNZ5Y99Tz6Kozh
         wX1Y0aGNDjYyJO7RgHExqe8MepLM8wTMl/pMV4nTyuYagIzACdlC04OcNKGjOlywYndo
         xo2JfybKI8fpSJygh55VG6N+dV3clrhhEW46n7q5DMH0HRlkFAk4vAcG46lo7zso5Aql
         fisXTs58Sozsihv83QTSzxTjkvjk4v78QfYzSC7FTOhF52NRpL9Fu8d13u7vr/PnC1DG
         Lwqnlgha1v1B59GhYAjdym/fQKOYVb7J7KguTUzYP174tHHs7jeEASaITO0WyCUZSE6P
         BSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739507640; x=1740112440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS5Knb7XMjcuFKIBATQ7nHoTfU5um3mKBC4QXOJc2lY=;
        b=qZB3JZHeDPs/bIyAkbBq9P0DErsfNZ5QcFjl8ZOboAASFxcq+HLTJGZhowYJjGzMlH
         elT3QtGVuHBl6dKEADKipcrgTFGh7l3B1jryHKqpiYPJwMz4mslLMzEs0vHx1uPSXtXa
         Cnzah0gYTLlG+FJO2mwCVnPF6Txjg3jpo0KnYOVQBMoQZ1tQmTYjkZDxzjTf/0BaKDaD
         x+WtP3IyVAyAKipvoUbiJbeJB3QHesI0wn3rQc64AXMWKN+jMxUBy0IHSAA+n3cq8dqF
         WhcQD7NoG3y8FXKx9Lc+kQmgsB7rAdvkk2X79TESPVaCWtzisvHJoaX0I6qCYz3gtn58
         GYLA==
X-Forwarded-Encrypted: i=1; AJvYcCU1/pAfYOaQoFnkrCtI2MQbGuuBUDd/s+hQ4ziwoekyAsvfpSR8tensUyu0YTin+us91SP/MKHIIglT@vger.kernel.org, AJvYcCUqh89HbTNW4GEP1Jrr7/VC90jImlbzm77xgsAekcQHG2AzcrbbjjmthGumOJmS2sJRlH+lPhGHyOptqWrn@vger.kernel.org, AJvYcCWjx632P1d7dxpfH7DrNDqwi1m/V9nyKCm3SNjqs1pXxqPfg+AjA30nUUb4RvpZL5cp8sHNxQOI8UJj@vger.kernel.org, AJvYcCXxAsjJHmerFDR/176N5HmK/hKTw/58uWCcJAJxyXhwwb0+SColg3CkP4N9KXwQ+Oprv4DXzOIx46Ty4HJq/EzyXoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHi05MeYdWiWP/tMp0P1Caw5h5htZGKPTMqAyYqvkaZQyYaR9
	nm/QjlMEyoOuM489m+WOe8uZ6B7QdmvXJG6x+kQ0G+a/6HowKT8H1l6RYGBe
X-Gm-Gg: ASbGnctD0XeFP8F06TPf71n5dPSvL7HyR2l21gbeWMx/jYXpX/U7NiOcKx9DQd7XA1e
	8dEpuUmmw2o1ArBDo2L6ycJ6hn1SMWdI7HKqiFKkiPeQb/oIO620Xk/AuBTDhSimXjRcYtxx4vd
	Y5JGLlXm02OKNfkteac2NybAFBgzDVwtWS1i0gFuOVqPusIPMBiy3IhQ0jMmZekOZqtSxAc93MB
	iKquYw25s/jWMg1jUgTUWa2L/eotvWoWjoxXg7zf32YNHPlGeAKjHIFFTOrxetxnxivXrkpYY5C
	L09K3pPuurt35Wzit14ahzEeR+PlCbzMnc1GkJnrjkNb1PjBeL8RiNWn7cKpy3JyuishI536GsU
	+uA==
X-Google-Smtp-Source: AGHT+IGu2yT+6b55ONIteFeW+9c3gw8B023b8z/MN7APmsValfKFvdqzpCJHgJPqR1gvD0CzamOr1Q==
X-Received: by 2002:a05:6102:e13:b0:4ba:9a20:dcf8 with SMTP id ada2fe7eead31-4bbf231943fmr9155562137.21.1739507640049;
        Thu, 13 Feb 2025 20:34:00 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e857f2desm422800241.10.2025.02.13.20.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:33:59 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v3 1/3] spi: dt-bindings: samsung: add samsung,exynos990-spi compatible
Date: Fri, 14 Feb 2025 04:33:41 +0000
Message-Id: <20250214043343.263-2-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214043343.263-1-wachiturroxd150@gmail.com>
References: <20250214043343.263-1-wachiturroxd150@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "samsung,exynos990-spi" dedicated compatible for the SPI controller
on Exynos990 SoC. This ensures proper representation of the hardware
in the device tree.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 3c206a64d..1d3c95bd2 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -24,6 +24,7 @@ properties:
           - samsung,exynos4210-spi
           - samsung,exynos5433-spi
           - samsung,exynos850-spi
+          - samsung,exynos990-spi
           - samsung,exynosautov9-spi
           - tesla,fsd-spi
       - items:
-- 
2.48.1


