Return-Path: <linux-spi+bounces-11496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD322C8326E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 03:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53D6134235D
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 02:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30D21DDC33;
	Tue, 25 Nov 2025 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqLIEfvi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26F1D9A54
	for <linux-spi@vger.kernel.org>; Tue, 25 Nov 2025 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039459; cv=none; b=QdKr/ZTCSzB4Vdz/Ubf5hwzZubw73qdjZFwXHjjKVlt/3HUMu6RM/biur+lBXd+8CmFAHD0Wk7UrXQeT5S9Us9k+rhnGhcrCE99I165+lvtmrmVMlt4dtbn42CCPQoe7ZQdmFOpI3uinOp2h6tXn11b0GLggdcUV47heu+oXMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039459; c=relaxed/simple;
	bh=vW+VeFvhIaURy2ghOdtsK6v6Wmgkd1HzYr37QzQlcws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pacejxpkVc7FfJHxEifRkjkJGDCiN/LOo2f4V7jZ2s1tHvWhjVOrfv0r4AiDl5xnV4b6lwvxcnMQ+2DSoJZHhK4fvTOYuvwK+zUrhewKAhZqTyw9hm1uqHwGrTpZgqDSU2+ivU6NoFsKVHJwoPR3WPlynBs55ujyOkkAwwHKUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqLIEfvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E07C4CEF1;
	Tue, 25 Nov 2025 02:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764039459;
	bh=vW+VeFvhIaURy2ghOdtsK6v6Wmgkd1HzYr37QzQlcws=;
	h=Subject:From:Date:To:From;
	b=eqLIEfviNmJkkG5yv3kcBmlQ1i176kb+HYpdEp/E6tfTXYdP+TNPys47637fSmJjp
	 N5J30GRTwTgxlhhYBhr2wFhKLEaEHm4W2Fvo/uw/joRPuAIVFnHmZaSXgapjo1WHws
	 7x7TrXNL6ZyROB7pg5JgaUv2TkgFajiAlaaBaouoEt8FVSJe9XheemC1L8Ed2P588K
	 qo77bpzvJN4xSFQlfXsJRXWH0gk4FIJyhWTB7f1Fjlue8lQ9j5fGzTurtrWlJQb1hd
	 BplXOXgx+ruYXuc144/jGe0g1F8Ji2qMMIhcHv5KVHTrSLejU0i5/0SEN8jq0B5HGF
	 7ALwg3akROB1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB18A3A8A3CA;
	Tue, 25 Nov 2025 02:57:02 +0000 (UTC)
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
 <176403942146.163802.12245551749896862473.git-patchwork-housekeeping@kernel.org>
Date: Tue, 25 Nov 2025 02:57:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-25T02:10:48)
  Superseding: [v3] spi: airoha: add support of en7523 SoC (for 6.19) (2025-11-20T04:27:50):
    [v3,1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
    [v3,2/3] dt-bindings: spi: airoha: add compatible for EN7523
    [v3,3/3] arm: dts: airoha: en7523: add SNAND node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


