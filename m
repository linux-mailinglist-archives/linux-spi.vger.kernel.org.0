Return-Path: <linux-spi+bounces-3987-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B144193B45D
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 17:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650621F2493B
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 15:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3009A1598F4;
	Wed, 24 Jul 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc+oY42i"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA315CD60
	for <linux-spi@vger.kernel.org>; Wed, 24 Jul 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836596; cv=none; b=k5D6mD2ElNwtWtsfrm2BDl4AcdFlFQZeQF8XXTbiqZAZK3Ux9Zb8XSOWB26gdPAG2NmBiL/tA3zT/DJUHVBSqZGYKLpjgWYhtg4pMang/LOBZ+Hes9esxpzWEdPjjolLuY0TrFt0H+AalSfeJWEW6SbeQ6k9uyOzm0L7Bw/7d2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836596; c=relaxed/simple;
	bh=CjQrMFZ8JiJ8P1GjlJUlBGs1JvgN9ApDhBrqvecOr2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GL3vcNa6m8p6WshxhYnpab241J16h3Z9rIiaptDTtf5fQOXR5+4O37w8Njl84WF/nbRsHIOMKqi6BUguYPCt6FRynMIgDFubEVt/bU7LkgxYQIWMO4UXVMf4mf6KsdqV5kcl5JkG6fdhHuNgg2IfnRDFROuZs/E9wIwCWe/HU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc+oY42i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82904C32781;
	Wed, 24 Jul 2024 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721836595;
	bh=CjQrMFZ8JiJ8P1GjlJUlBGs1JvgN9ApDhBrqvecOr2s=;
	h=Subject:From:Date:To:From;
	b=Bc+oY42iRAGZAsCjuRNr3uK0sK183WCHHVlQBjnHzkqJd2+OHjUo8rsak+ceQEsAV
	 UmaFTUN+SfujWDtpF1daRgRD84LbhzDnxO10mwRP5OJup/Oo/+qqvbBNv2/VlXXyrk
	 Tg5kA0qDu6nR4kFNamnL/mfKQg8BheauTXQFlgEvpm7PKQeqIb0W32+v+iRW+VTwUe
	 xe0QHkvkxIXuxDFWJEKDTL9OpNWocu/nAl2fbNa/dYm4l4p91RuUL43gcRQL9T7tYX
	 IvA4bx/dscjZQnWfnDKxOYEG22nauCE0Xdb4FqZjFXcuCmO8acug7u3fuRetxEmUbo
	 +M9x+0LyPDDjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E7A5C43443;
	Wed, 24 Jul 2024 15:56:35 +0000 (UTC)
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
 <172183659544.5549.1154949917500767681.git-patchwork-housekeeping@kernel.org>
Date: Wed, 24 Jul 2024 15:56:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v11] Marvell HW overlay support for Cadence xSPI (2024-07-24T15:47:31)
  Superseding: [v10] Marvell HW overlay support for Cadence xSPI (2024-07-09T22:12:03):
    [v10,1/9] spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
    [v10,2/9] spi: cadence: Add static PHY configuration in Marvell overlay
    [v10,3/9] spi: cadence: Add clock configuration for Marvell xSPI overlay
    [v10,4/9] spi: cadence: Add Marvell SDMA operations
    [v10,5/9] spi: cadence: Add Marvell xSPI interrupt changes
    [v10,6/9] spi: cadence: Add Marvell xfer operation support
    [v10,7/9] spi: cadence: Change resource mapping
    [v10,8/9] spi: cadence: Change cs property reading.
    [v10,9/9] spi: cadence: Try to read spi-tx/rx-bus width property using ACPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


