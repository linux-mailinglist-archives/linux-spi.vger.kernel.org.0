Return-Path: <linux-spi+bounces-4177-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7953E950990
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 17:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C539B27C57
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7561A072D;
	Tue, 13 Aug 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjfbgndx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948C2AF0D
	for <linux-spi@vger.kernel.org>; Tue, 13 Aug 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564585; cv=none; b=RPRvvRk3Ep1OGSO9llFJ1NhZb2uncdlSCFBMo0TX2NLwSypRqPBqnH8rFZFDepn9KB8aTou8lOY0Uay+tu/2TNesxLzsgYmTfDYuL24OCsn0NeiPc3Im06U/btTMVUqK+Lapp8ixziruyccHD1Yv6HBBYYtBJxII2IKX122RWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564585; c=relaxed/simple;
	bh=JeKNRnEqPEWxOrq7OEyMeQwMsnwYQwChWcO6J7MIaa0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VRX/7KNMpdSqR9XcXfnlYDpbUVnkO38YB0u6C6WfWivOJSHFlmr6XW4CQ4TVgJ7xsH2Kgj+PHQGAPkN6foDMvevUZT+4VxzteFnP6vTfm5+IAHgyQagEKOyjsawERzo46OyHZMe9f3mYKm+zcHIEIZ+1ITlDFzwicWRBf8LNhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjfbgndx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC816C4AF0B;
	Tue, 13 Aug 2024 15:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564585;
	bh=JeKNRnEqPEWxOrq7OEyMeQwMsnwYQwChWcO6J7MIaa0=;
	h=Subject:From:Date:To:From;
	b=cjfbgndxqByTtJZLIavQkPCi1jdusSu5ALs5fmkjOG5EM2Td1J4H+8V6Owsn9tw6a
	 yIU1YcqhrT4wFXGHqp913sjB+T3jXI9Gqf5aeTtrohUnVTwU9vqt+mbkrbpA6rEp7H
	 GwBOrIZsLhUq2dc9+CbiPzBIDUM5jD9dkGP4Zd47HUd8suxU0nY3Iy+qJvLLtGV10S
	 GdJ90d3OJQOUWC+fjE1X0Q4271LEzo+N8wqkn4ug9tBVw9e7mLCm4OifXMnpsRj+RA
	 NQ+lGcUw3sVsOFo8J/MZTS/gEpAqCWklf4XS8/XypxSU5hZwg+NxXHbwRvJGtOnRdW
	 IfNK26jC8/OpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3476A3823327;
	Tue, 13 Aug 2024 15:56:25 +0000 (UTC)
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
 <172356458384.1681143.12716779134495147555.git-patchwork-housekeeping@kernel.org>
Date: Tue, 13 Aug 2024 15:56:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dt-bindings: convert spi-sc18is602.txt to yaml format (2024-08-13T15:44:43)
  Superseding: [v1] spi: dt-bindings: convert spi-sc18is602.txt to yaml format (2024-08-12T20:30:03):
    [1/1] spi: dt-bindings: convert spi-sc18is602.txt to yaml format


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


