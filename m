Return-Path: <linux-spi+bounces-10221-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE03B9252E
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 18:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58157AFF8F
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B43126B5;
	Mon, 22 Sep 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7WCyB+R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78C31195A
	for <linux-spi@vger.kernel.org>; Mon, 22 Sep 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560222; cv=none; b=h4VxEPRuTGwHRdIqbBOMqFLG9YKYQNmX+sXmYfsz6qrmR55BC1h00eGMPwVbh0echhkFIogj9nkl3RUX+8L51TfZZBj4cngG1g5II8rTv3LcjzgG8KgZ2TVjsZMvBo8zltzzevt6LGJZd4moM2bCr7b+/S309eIt6Wh+fJQJWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560222; c=relaxed/simple;
	bh=5oI1vsJKqEbgMQ53ijvqFQYQ1gYHP8FwIFLeVtUFlOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=N3UP+dEwdmqxiCdHMLgmw9+B9BNmwMCcxM74yVD3DF+x90iwIWlZxG5eDS6xL/3V5cbhhFRjFosJ5sc4xkwb5EF5zdeTPLu0J5lvcscfucKqZC4fzgccwBvJYo9hZj1sEiFqYDomwQjydSNSPEAZWJZkORM2Ze8rkP/jz18luio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7WCyB+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CB5C4CEF0;
	Mon, 22 Sep 2025 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758560221;
	bh=5oI1vsJKqEbgMQ53ijvqFQYQ1gYHP8FwIFLeVtUFlOY=;
	h=Subject:From:Date:To:From;
	b=E7WCyB+RSNpnpODubIVTzuAffmskq2Ump/PnA+l+g8LxpCn100pz5CFRRxaogvn66
	 spG3XKpkPIKTnmkJrUbpw6hwn835DbQZcEG5EHJuv5plPNbJRK5E7kQfwXU9ZJkprr
	 kzJYEP8bAyGTYMnrxErPZjK9pW9vs/mYamdOttIfXuI0u1mGuMOVnSFXHwM5zTS0Z1
	 4CJhtvaF+Qz/DFvCUK9aVKyEVaIbA6GVC2nSZ3aM77DTdqtHTfDPVZyKPAKbQiNHWb
	 rOnkMQyTpxMGjqEiSmrH9BPNaNtVPWQsh53hHwmFMDAPaS+Hz74vRqOb6a5Fdq/YZv
	 Sap+dMuW8tt5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0F939D0C20;
	Mon, 22 Sep 2025 16:57:00 +0000 (UTC)
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
 <175856021932.1081530.12074369379431541433.git-patchwork-housekeeping@kernel.org>
Date: Mon, 22 Sep 2025 16:56:59 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: support the SpacemiT K1 SPI controller (2025-09-22T16:17:13)
  Superseding: [v2] spi: support the SpacemiT K1 SPI controller (2025-09-19T15:59:10):
    [v2,1/3] dt-bindings: spi: add SpacemiT K1 SPI support
    [v2,2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
    [v2,3/3] riscv: dts: spacemit: define a SPI controller node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


