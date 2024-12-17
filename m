Return-Path: <linux-spi+bounces-6090-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9C79F5528
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 18:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C0916E379
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A9B1F866E;
	Tue, 17 Dec 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FORHhzhY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773753389;
	Tue, 17 Dec 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457454; cv=none; b=pzCIhpb60tC8OxT7f6ZMWW2P5o+d6SO5HkeoAJW7xy8+1YYgjylHwUtO7Ncy9Czy/nlmkVVCyffJII8ukXvuVJwNGJr0VHk1jtqMSqpmiefleKXSCKh9q4hKfSjwX8ynQuwZbanwSjINZyw7ridPokBEYYsNY7DdX0WhEdhku8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457454; c=relaxed/simple;
	bh=UjCTbZRIas6m3xWUpHQJN6H1rzcr68mAs5Q3i7DU5fw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ylndkh+fIpsr8zDLhm7iQq/Kp49g0RFuRN2+IOc7k8ET2cRRLGbJzYhqtp8VIjj6/3CSjlxIp2GrvBTkdjzy3Wuto5/UNq8pYPU6LVo6pX9kwbxAF9ABS4fDNySH1ApoCc2Nb5LzIw51L7Go1LVn0ZBwC8e7D6e1TiMkbiJhExY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FORHhzhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50038C4CED3;
	Tue, 17 Dec 2024 17:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734457453;
	bh=UjCTbZRIas6m3xWUpHQJN6H1rzcr68mAs5Q3i7DU5fw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FORHhzhYPbPtfXzB49Gbw6mWpwu2ZYjt/ryS683kjfbxMWkDworVDJZMxK0rqK/Ib
	 GAB7SSoJnxX4F7tBQZ3RcPTMl/ifRHiued0CL1pCTBTUVS1HkV+FYZ3npjlCgmGtZQ
	 IDzNCgfk7wRdbu/F1tqIYn/ERMPuijcwikGb6moYiQcdkqWyoc4DxSDgOISA0RZwkF
	 7FcbNlj8aKseU252Dh+yNDwv5P9nvaopWs8cbgYMaKiyljQ7y83lzWDZ21BEAP99tP
	 lbTrq3ocWEZ9mGpKGqJmlE0PFloGo80WGgJ0KLXZG13z0NyNE4t8Gok6QE56kqIJzq
	 9rbv0gMF74+hw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, javierm@redhat.com
In-Reply-To: <20241216095739.27320-1-ikerpedrosam@gmail.com>
References: <20241216095739.27320-1-ikerpedrosam@gmail.com>
Subject: Re: [PATCH v3] spi: dt-bindings: Document CS active-high
Message-Id: <173445745201.131319.3705546352249156855.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 17:44:12 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 16 Dec 2024 10:57:33 +0100, Iker Pedrosa wrote:
> The current documentation does not clearly explain how to invert the SPI
> CS signal to make it active-high. This makes it very difficult to
> understand.
> 
> This patch adds a simple explanation on how to set the CS line in
> active-high and adds an example to make it easier for users who need
> that setup for their SPI peripherals.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: Document CS active-high
      commit: 7b4035ebf2af2c2f1450e8c38bf4f41acd3f01bf

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


