Return-Path: <linux-spi+bounces-11110-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1288C3F64D
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 11:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F139E3A6D6A
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A3C3043DD;
	Fri,  7 Nov 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMEIJkGp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339223043D6
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510835; cv=none; b=tu3adj6A/GrDJrxkpuazzCHUcFge2n8CwTct6HKlUBOZm2LGu3UCoVxCzhsh6Mms8dqkasGJP7p/2iOpux+3IzNwo0ZUDIiCZlxyYSTO9uT3Gj+Z6ZG4D245NLWydbwoQ4kIcAhPD9eq6DeoDGTyAhU3GOSlf4tfPXjWejYoSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510835; c=relaxed/simple;
	bh=Qxi5tnSveopj+LNLEhXeVJ2u4Ll2zKeleLk4ksxEnmo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LRNgA4ig39uxuUI8ynOcZt+26URBjN71qj87d9nWwrqlmG49lrZ+WNsPAqtO9kgSzVkC9rya6fi1dsba16t8Fc484dZBBIo7TPuFp6mq5/x2Kpa9fveu33MROrnTEgFku8D966oH3y3CGUvcAjnla6DqI33ECE+AJynyOPPSjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMEIJkGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB7AC116B1;
	Fri,  7 Nov 2025 10:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762510834;
	bh=Qxi5tnSveopj+LNLEhXeVJ2u4Ll2zKeleLk4ksxEnmo=;
	h=Subject:From:Date:To:From;
	b=gMEIJkGpsEihy8qlBNpt/bFF/aixkjeqHFFG0Y9QNE2gb0+NtmcetntToqC7Btiu4
	 Weti/fnaeIE+Q6zqQNjyXIZn+OIYnKMOKo2vjyLEuJZQTSVDO5vFq+Kv3AHJxDAgIo
	 fo24nhwuQjoNkA86zmm1SE67SRWATg2hx+XwFZ2IzJGITvcx1Qd8oXLSK89OTQ70fA
	 HBt+9KkObZXqTw2d6i9eQqS2XxXhOyN7WrgCdjRdvb521OXZ6GEg7Kl7RQxsqbwXr3
	 QuDqgS1Yb6uDdK418vcRh20/8XrcVk2nc7/xAOTYJROGrpenOLgY4lMQaayatvI7KH
	 1hpOUGspq+C1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7466939EFA54;
	Fri,  7 Nov 2025 10:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176251080704.947643.16983879936560326131.git-patchwork-summary@kernel.org>
Date: Fri, 07 Nov 2025 10:20:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: enable the SpacemiT K1 SoC QSPI
  Submitter: Alex Elder <elder@riscstar.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1013683
  Lore link: https://lore.kernel.org/r/20251020165152.666221-1-elder@riscstar.com
    Patches: [1/8] dt-bindings: spi: fsl-qspi: add optional resets
             [2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
             [3/8] spi: fsl-qspi: add optional reset support

Series: spi: enable the SpacemiT K1 SoC QSPI
  Submitter: Alex Elder <elder@riscstar.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1015146
  Lore link: https://lore.kernel.org/r/20251023175922.528868-1-elder@riscstar.com
    Patches: [v2,1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
             [v2,3/9] spi: fsl-qspi: add optional reset support
             [v2,4/9] spi: fsl-qspi: switch predicates to bool

Series: spi: enable the SpacemiT K1 SoC QSPI
  Submitter: Alex Elder <elder@riscstar.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1015617
  Lore link: https://lore.kernel.org/r/20251024191550.194946-1-elder@riscstar.com
    Patches: [v3,1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
             [v3,3/9] spi: fsl-qspi: add optional reset support
             [v3,4/9] spi: fsl-qspi: switch predicates to bool
             [v3,5/9] spi: fsl-qspi: add a clock disable quirk
             [v3,6/9] spi: fsl-qspi: introduce sfa_size devtype data
             [v3,7/9] spi: fsl-qspi: support the SpacemiT K1 SoC

Series: spi: enable the SpacemiT K1 SoC QSPI
  Submitter: Alex Elder <elder@riscstar.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1016282
  Lore link: https://lore.kernel.org/r/20251027133008.360237-1-elder@riscstar.com
    Patches: [v4,1/9] dt-bindings: spi: fsl-qspi: support SpacemiT K1
             [v4,2/9] dt-bindings: spi: fsl-qspi: add optional resets
             [v4,3/9] spi: fsl-qspi: add optional reset support
             [v4,4/9] spi: fsl-qspi: switch predicates to bool
             [v4,5/9] spi: fsl-qspi: add a clock disable quirk
             [v4,6/9] spi: fsl-qspi: introduce sfa_size devtype data
             [v4,7/9] spi: fsl-qspi: support the SpacemiT K1 SoC


Total patches: 19

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



