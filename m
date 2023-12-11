Return-Path: <linux-spi+bounces-220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9C80D9D5
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409171F211A3
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA53524AE;
	Mon, 11 Dec 2023 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beoXehs6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F1E548
	for <linux-spi@vger.kernel.org>; Mon, 11 Dec 2023 18:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C35DBC433C8;
	Mon, 11 Dec 2023 18:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702321005;
	bh=6iOvn9nj8o2jd+8MbpzuyNnIo+cMpeE6lmW8w3dJr3M=;
	h=Subject:From:Date:To:From;
	b=beoXehs6qyaU2g3njeAGi3cVYfeFBVvM4SFNycqLN0IEwDoVAPiHsqhT4CVEIURK6
	 5/rq8Zvx2nTQJwNmFo4r3Jc3C3CAnCpU4GeVL6+k6oOIoEIZ5kQod3KvSbQcDEqwmS
	 JqdSTm/CK00ItdLWg0Jd6iveeLUf4K/gRMO/cTNKGC63jdpqD1bZSQivMK6t8vryff
	 1MUEQB5GWw7SCHpdo9ByOevDqxMDbwADuCMhNDfhNsCKI6mKVJ1EO2bDNRosWvMpjy
	 g5Y+3yssoeJjJGidWRo8VAOHCpahMX77fZ5GT0MfF6b9QgBNhv/hG+L27tZbbVdSgd
	 l3m1sC5vQCzAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF987C4314C;
	Mon, 11 Dec 2023 18:56:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <170232100571.2760.6301177429813255375.git-patchwork-housekeeping@kernel.org>
Date: Mon, 11 Dec 2023 18:56:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] Introduce STM32 Firewall framework (2023-12-11T18:30:34)
  Superseding: [v6] Introduce STM32 Firewall framework (2023-10-10T12:57:09):
    [v6,01/11] dt-bindings: document generic access controllers
    [v6,02/11] dt-bindings: treewide: add access-controllers description
    [v6,03/11] dt-bindings: bus: document RIFSC
    [v6,04/11] dt-bindings: bus: document ETZPC
    [v6,05/11] firewall: introduce stm32_firewall framework
    [v6,06/11] of: property: fw_devlink: Add support for "access-controller"
    [v6,07/11] bus: rifsc: introduce RIFSC firewall controller driver
    [v6,08/11] arm64: dts: st: add RIFSC as an access controller for STM32MP25x boards
    [v6,09/11] bus: etzpc: introduce ETZPC firewall controller driver
    [v6,10/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
    [v6,11/11] ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


