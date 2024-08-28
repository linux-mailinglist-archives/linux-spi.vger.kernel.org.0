Return-Path: <linux-spi+bounces-4357-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5901962D11
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F334B21458
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE611A0718;
	Wed, 28 Aug 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnrWBdkK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D10172767
	for <linux-spi@vger.kernel.org>; Wed, 28 Aug 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860594; cv=none; b=mU1kQjPB0hqO0tCnFaAA/XXConAUlI1zQkPVSkrllrkHsmrLHN8EuagHJucYkCs56eECOsF2UH/oXDbJmp8WI1G5X0sx8BJEA/IXFV4GJsv6EuPxM+an1rqsDiMyGXfHSAGFRXClMnplkoe9roPhObMfyRe/gfjovd5TKFilIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860594; c=relaxed/simple;
	bh=0f4Z3iQakwb+2SFwL2j2MoSal4b8KwYIHbD0tfeU9kI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=K3Hpit8WKR4SsUTL8Dkxux24rs9J/8etRl6aI5flUvWYS/JFjudCy7zWs2viVYPwwAtnhRBzDuBPrdsjASJTHG+XUWLCJwV5ETY17UelWv2MIZ2g21z4pB2D2Om+TGzq8IPsRCDaAO1eLKK41NMEQJPUO4rGRE5AAe7VGzep4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnrWBdkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57AFC4CEE0;
	Wed, 28 Aug 2024 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724860593;
	bh=0f4Z3iQakwb+2SFwL2j2MoSal4b8KwYIHbD0tfeU9kI=;
	h=Subject:From:Date:To:From;
	b=XnrWBdkKpQlUiF2X84vJNWMKvNKoD42ITaFLqImKPYszNos7Lcnu1pODUjP1cBXj6
	 Wh6IKxz3EfaTT3liCvwcXerKMvoyFnwbT4wVfzZeYvcil9y707LoUOD94FNHriD8Da
	 6wejtnhbwDPz0Exe7Aw0X6nCcYiJQvT9+9ot0C986gyhWonOep+UWv+osP0CiCS9Db
	 Zv5teq7m87cVWpZ5v9RaCUmajcaP1r+FpmxrxRjenTQ9sOl7vd+/fp+PAxFOF1UweT
	 cwCU6vUKjhRXvLwfHb5uJeVPuj6iUKDQ+R7CWLji5Dnug8fIadCq/CWR9gZK+wLbLV
	 fJ1Yt+EKjCDlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3477A380666A;
	Wed, 28 Aug 2024 15:56:35 +0000 (UTC)
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
 <172486059373.1309529.13269063945511583390.git-patchwork-housekeeping@kernel.org>
Date: Wed, 28 Aug 2024 15:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add device tree for ArmSoM Sige 5 board (2024-08-28T15:10:36)
  Superseding: [v2] Add device tree for ArmSoM Sige 5 board (2024-08-23T14:52:27):
    [v2,01/12] dt-bindings: arm: rockchip: Add ArmSoM Sige 5
    [v2,02/12] dt-bindings: arm: rockchip: Add rk3576 compatible string to pmu.yaml
    [v2,03/12] dt-bindings: i2c: i2c-rk3x: Add rk3576 compatible
    [v2,04/12] dt-bindings: iio: adc: Add rockchip,rk3576-saradc string
    [v2,05/12] dt-bindings: mfd: syscon: Add rk3576 QoS register compatible
    [v2,06/12] dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3576
    [v2,07/12] dt-bindings: mmc: Add support for rk3576 eMMC
    [v2,08/12] dt-bindings: gpu: Add rockchip,rk3576-mali compatible
    [v2,09/12] dt-bindings: watchdog: Add rockchip,rk3576-wdt compatible
    [v2,10/12] dt-bindings: spi: Add rockchip,rk3576-spi compatible
    [v2,11/12] arm64: dts: rockchip: Add rk3576 SoC base DT
    [v2,12/12] arm64: dts: rockchip: Add rk3576-armsom-sige5 board


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


