Return-Path: <linux-spi+bounces-4016-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559D093DF2F
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jul 2024 13:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9651C211DB
	for <lists+linux-spi@lfdr.de>; Sat, 27 Jul 2024 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF751C4A;
	Sat, 27 Jul 2024 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuWXcWh8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01547F4D;
	Sat, 27 Jul 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722080924; cv=none; b=txq8FkcSWPImmsnBfUJhy3WUWqrzCu59qn/mKHQ9azQlYe9nlXLUM5nMexwIUfepagEOw1LQE9XL+j3xNMN26qbAyBaTTGA4cKXb7P1lgScnBqrR4N4hHFJ3lp9sHRLO0GZwYO9WfvFZpmsaRVbshqeH1Ys2QshSyULpNeJFSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722080924; c=relaxed/simple;
	bh=xePYhf5JZpZRCXEGSedhKYK/NETm1UKXJowXK0smBxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F82jI+Wlndjmae90BT3BZOzCM+JwHRQM2qUl67H9RaoJ/jlMd3WLvCSVBoCotqL6O3CelMfl08RfQw1EUHDIx2reu1XW/4YK2sli4fnSB8BQdQxhbvA0x2c6S6Grs48AbytMJSfgmGEKBoHyKlLlrx8AFDpL1crBSMozkdXYTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuWXcWh8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7d26c2297eso244479366b.2;
        Sat, 27 Jul 2024 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722080921; x=1722685721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fUm8LNjWnpXgKPOWByxyCK8Ra7TdsmOZpgB41hWfh8=;
        b=GuWXcWh85fRgA8zKN4DGA1xuvsczOxucEO0MElPa1MiDpAoCS7/lEDzHT5mdYunrOc
         d7f+DvkW4qD4m0LuVa+5fvdwn2ZK+kHzgL0F600t1FwfGXw7gR2JSUzN9JywuKuswROF
         MBSAhWHst5/qdmymJ+UN8Xr+ndTnBQfsIWUTVbzHlXYSaQFL6U7zUWdA11RbQE8HIyaT
         6a1yJsmQg2q+7PUIYAv7pBCqEvKPCcrYu9a8S8t69suxYK0B7j7w8C8oem4/kdkM5upp
         AfY+22fuqlSj4l6LmGzr6RLKAAg/ZPtJNB6trnOg8jRYG9224Lb+zZLJDIMBnAd4JMaL
         kA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722080921; x=1722685721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fUm8LNjWnpXgKPOWByxyCK8Ra7TdsmOZpgB41hWfh8=;
        b=vyJmk4JS4n1nh8nbS1Xg1TuI6Wg9JCC4DF+hRITmvxnOCHEWeAZxmGwLNFvhfnIXiX
         b/pMjlfZ7fhDnKiNmqJ7vqaobZyMlPk6a/aVmISfo/ZW5qLdtnCshe9xn2ltyKwz13tQ
         gW56QjDpI3HUMBPV0mB4cnh2ag9ZV5B6dmmA6Z2GW4ON2WMMRfDoSiPXeAO6SKQtxvnr
         +f3JNashSN603kaxjILq5BDWEf76fskvDyuN0OymgvEZM/Roh+6n9NaHX5YthMufc55A
         CBFZzcJigFy4Da+bm8gghMDG6sk7dMlTy2oVSfelnMv9Atb8nkqHmsv5OO3N36CHvfIQ
         wmrg==
X-Forwarded-Encrypted: i=1; AJvYcCUXcnQOPSwwtpIj+4n8+x05lilSsFnx2vC19PPVKDUmbegUUo8ZAsgSC7jQb9XARUby2EtEoHbK5dBwKerSSKyC+QA5W8W6mvyI+0pZepDCs8obMHXsGHsXLm9O+coaQ0nFFl1/hg==
X-Gm-Message-State: AOJu0Yw5PM57EBKD47VcEqABl/2v/zS0/KIa9n8LNTL+qK4FOMQsYc9+
	Doy34X4ZEwVv77u8CSOHA1JxCPPiuBu/ltCcs8au2gPYUTr2vjPF
X-Google-Smtp-Source: AGHT+IE6w/99V21WjiNJgVmoVHMsNySZTuoAqu+JuOyTK0gkElTw6sWm4sv5b3PuRrjeKR45opBNlA==
X-Received: by 2002:a17:907:944c:b0:a7a:1cfe:a262 with SMTP id a640c23a62f3a-a7d40166f94mr112916866b.55.1722080921212;
        Sat, 27 Jul 2024 04:48:41 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9316csm272646166b.186.2024.07.27.04.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 04:48:40 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Leilk Liu <leilk.liu@mediatek.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	John Crispin <john@phrozen.org>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: spi: mediatek,spi-mt65xx: add compatible for MT7981
Date: Sat, 27 Jul 2024 13:48:27 +0200
Message-Id: <20240727114828.29558-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7981 has SPI controllers based on IPM design

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index b6249880c3f9..e1f5bfa4433c 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -33,6 +33,7 @@ properties:
           - const: mediatek,mt6765-spi
       - items:
           - enum:
+              - mediatek,mt7981-spi-ipm
               - mediatek,mt7986-spi-ipm
               - mediatek,mt8188-spi-ipm
           - const: mediatek,spi-ipm
-- 
2.35.3


