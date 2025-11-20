Return-Path: <linux-spi+bounces-11443-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D71C769BC
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 00:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1E0C35CBC4
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F11307AE4;
	Thu, 20 Nov 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3f6lNzQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D831DF963
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681401; cv=none; b=tO1K4gAY1Q1f+6JQxhNOUj+H55pL+sofSA5MuImVGfYBro8psrWlh5rmnag1YINjzD14V7HaPnqzMzTwTehVBU7K0pobrqEwVeJsOOxxBNNJobGOSuhPgvt/kcXrmaVeFB4/6W8nEWXCqdag0L8FSbTvXBCJ0J3DvTJjQW/oJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681401; c=relaxed/simple;
	bh=W4DaM94tPPtznOp7Un8ESSuQT5CGLy9fqdfzdwLWV8o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FHZYuA/OwxEwTGaPxzZd79tU7g+KFlzU1CzkiCDe+i0KCSUHJYp1xfAb7PYk8LygEvqOM061r+K1h+81gdk931ro+i7qi9PHjcDhuwFVFPEx6LoLP58YhEGjKtintPLatwk/lGMlX2PWkSqUr1NtQBzINhSU4r5gjZSSbapT+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3f6lNzQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso14010325e9.0
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 15:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763681398; x=1764286198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o99Q6btqe94dFwhCkqr9jpNEkkVzeqWoyeDeppPljwM=;
        b=T3f6lNzQRhJD2eJlcNSooGaayyfU53A1iUmsnGTqIQ/bH8qNcUq1eOOrQwAzpbMYi1
         p208yWw1X5XMSXrKPCugOP2Cb0YELEvqs8mnkPrPhiDHYowRUb732Jo4Yi4pZ2GsGDxH
         HGhccfgZUKspYTG9GHL5KLRFDITmAA/br6EccUnJ0AxOdl8x4+gFt1drogCFsB5oWrSH
         Qdx8t3l8eYsnaKJY/SG8PvuoIVcJJ97p++taTk/iOHDhw18tcPo/tUlpjBf5ER2nc9SK
         IVj5Y+r3YIudE/R6bqGTgHTtmFh0hcI8pAPQhMTDsIM+c+IK7K7hqT2Wiw9Lgscw76AA
         tU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763681398; x=1764286198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o99Q6btqe94dFwhCkqr9jpNEkkVzeqWoyeDeppPljwM=;
        b=DdRLuXd82FOXeUyCFu4l1iaGb+QUCkHls/45SJE29YC+0K++eAyH4AtzuuF3O6Onti
         VsKLRM4ugKEuViAechjXZn2uJhkVcK37+ojLrHgK9tdF5HmkgfC2WpMNk2YrvlfSogjh
         1lq5CFwfm71VYbdQyvg2ZTTcLUVJz5CZ/+jee36khlKqdHEZo8+EMzUm32FapVbPbti3
         bm0e7C6GT1cj4bhRp3MdVZvChUszZRr91qVtGeM+rBavVCM7+oG7RYFKylyUrG+KvNgI
         fUoIQtohNyDon/jhW8NpmQuZ6MomGOnZIcDhjLtcDqZ/GQyKM1AQO5mJXfK3fZHzEbOJ
         RDjg==
X-Forwarded-Encrypted: i=1; AJvYcCXsVucut6AhCd51pmrZ6b87Yw/QtW8thJ0moZexT2eWuZyzuBZxdMaqHIwujyO/XZyv3os88kGAsOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVjkbqWLuLu44+NwOrjJQlGpM68Y2oKdTm3DAs8JA2+z0nsFQJ
	mh4HV3GEBHqSMKLbMZ0ErRGb6lAd3OnZmvhBcP7z2AmLtc5iXEgyS5gK
X-Gm-Gg: ASbGncv+of1aLKclkErvuIwVcNoG6kZTOkhtHukRqjLReA0chAzUxNd3XOzgSO/6zAo
	Xs5cYGsbfT2JHvkdHWcoNWR+8AAaMJ/MofLiLfBaEU/Sw52h/efmmU6SoPuIVplW+bdnnXNla6a
	LttEEFt91e+L2LF05Qtc6+/xIbC5SddkPA5YKWmhER/mpl2QLaBFEnETJfTAy1JHIaK720fSaTa
	zEwGfbe1O8c5ycWWzn2PfaP2qDNA9xVVlE7pBZ2ybKMGaSz4eKuIeFZY0Xi6wtlknqKSZF62eJP
	1pfF+gTVfO2PzEoYhnJ6OYTonl2lGCBzYIOkdQIMY0Vv8Y7GXpryj/JAVNPbizd/SuK8oRJdey1
	bC+b+2wwhCKZDAzHcbEM/0o1lie09p8nMdWwHbgBXG9O7HpvevG24GM+56PeolKzK5EB7R87Ps9
	fMzxaiB6LARywoFqPg4y+le3yG4f4d5YbrVfncTxTr
X-Google-Smtp-Source: AGHT+IENcKDSU9p5/g82mvjpGvvEKuudRdiDvyXXEFjAWRPw+rHnGQTHf31HMHlBDVIX2Yzva/jh6w==
X-Received: by 2002:a05:600c:45ce:b0:477:79cf:89d4 with SMTP id 5b1f17b1804b1-477c01ff270mr3630625e9.31.1763681398280;
        Thu, 20 Nov 2025 15:29:58 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9022sm7776315f8f.36.2025.11.20.15.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 15:29:57 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cyril Chao <Cyril.Chao@mediatek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] ASoC: Add support for Airoha AN7581
Date: Fri, 21 Nov 2025 00:29:09 +0100
Message-ID: <20251120232913.32532-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add all the patch and documentation to support Airoha AN7581
sound driver.

The card follows similar implementation with Mediatek with
the codec present on i2c but with a simplified implementation
register wise and additional frequency supported.

Christian Marangi (3):
  ASoC: dt-bindings: Add Airoha AN7581 with WM8960 YAML
  ASoC: dt-bindings: Add Airoha AN7581 AFE YAML
  ASoC: airoha: Add AFE and machine driver for Airoha AN7581

 .../bindings/sound/airoha,an7581-afe.yaml     |  41 ++
 .../bindings/sound/airoha,an7581-wm8960.yaml  |  67 +++
 MAINTAINERS                                   |  10 +-
 sound/soc/mediatek/Kconfig                    |  20 +
 sound/soc/mediatek/Makefile                   |   1 +
 sound/soc/mediatek/an7581/Makefile            |   9 +
 sound/soc/mediatek/an7581/an7581-afe-common.h |  39 ++
 sound/soc/mediatek/an7581/an7581-afe-pcm.c    | 456 ++++++++++++++++++
 sound/soc/mediatek/an7581/an7581-dai-etdm.c   | 371 ++++++++++++++
 sound/soc/mediatek/an7581/an7581-reg.h        |  61 +++
 sound/soc/mediatek/an7581/an7581-wm8960.c     | 170 +++++++
 11 files changed, 1244 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/airoha,an7581-afe.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/airoha,an7581-wm8960.yaml
 create mode 100644 sound/soc/mediatek/an7581/Makefile
 create mode 100644 sound/soc/mediatek/an7581/an7581-afe-common.h
 create mode 100644 sound/soc/mediatek/an7581/an7581-afe-pcm.c
 create mode 100644 sound/soc/mediatek/an7581/an7581-dai-etdm.c
 create mode 100644 sound/soc/mediatek/an7581/an7581-reg.h
 create mode 100644 sound/soc/mediatek/an7581/an7581-wm8960.c

-- 
2.51.0


