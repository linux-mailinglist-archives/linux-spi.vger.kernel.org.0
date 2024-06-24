Return-Path: <linux-spi+bounces-3559-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF93915772
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 21:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7786286562
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 19:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0B19FA75;
	Mon, 24 Jun 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2ptslED"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF19383B1
	for <linux-spi@vger.kernel.org>; Mon, 24 Jun 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259003; cv=none; b=PvatDkFRRGcxSSn2pmvLvgpkUSlklMUw1I7oA6R+uCzRUfEqjkTo5r4FHOxclChSTrHJaeZlbfCsiN59f6MYwz07F8SB7pCO/70d8ClOUT6GKyDb1bGQD6k0fKk+LH9eoWcwT13XUCO5F2p3TqcK9igaQOQLJzmGHIhPaV8Ndis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259003; c=relaxed/simple;
	bh=ru1lFfSWXFGGhLCIidW2zysHG2JQO2TZ8HsD5wk72Dg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=I/PnrjdSthwAGsCvsSY5iRc4uDCek0B5EuCyXAkjExUq7lF+XGcgrtEq/HBwyzYY9FH/anXF3qLBFljMmXnN4Z10DRGqKx8FtJjPW2RkEBqAeBb0wQ+fAtl45H6s4iFn9IkvlW09D0MDDCtij2dHdntGasWLmeFvsUJX1o4oZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2ptslED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEC09C2BBFC;
	Mon, 24 Jun 2024 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719259002;
	bh=ru1lFfSWXFGGhLCIidW2zysHG2JQO2TZ8HsD5wk72Dg=;
	h=Subject:From:Date:To:From;
	b=J2ptslEDBWVYq478O/ryub1/0qFGTbxe/erjZE2Q58jTlpkb/KexSE32kwrn4sooL
	 sQM7cL4TiJ/oj3Z01yIVv946QddG4p0XbF3erFZNXgr+lSOi/j9aE/fddyT/FjhTNM
	 JRWQt55lZBL1v91hP5Ey/YQdlevMQvgtiQ1dOc18xkd/9HonnNjpzkCgj3hmg1vXya
	 /An5jGmKVFeoaTVVyfAQtND0U3K1b4qW+b9dUkpgW2t055uAJVNKpH5CYRYkRjQaGP
	 bz9yILtiUon7mVFgHGERW3CdB1o3A6nBeAQGO1DsUpWBnnojcbUkInIULoH1zXuytG
	 IB719Gfg4I5Pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9F35C4166E;
	Mon, 24 Jun 2024 19:56:42 +0000 (UTC)
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
 <171925900282.3329.13206172138860318895.git-patchwork-housekeeping@kernel.org>
Date: Mon, 24 Jun 2024 19:56:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: fsl-dspi: Convert to yaml format and use common SPI property (2024-06-24T18:55:26)
  Superseding: [v3] spi: fsl-dspi: Convert to yaml format and use common SPI property (2024-06-20T16:58:26):
    [v3,1/3] spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
    [v3,2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
    [v3,3/3] arm64: dts: fsl-ls1043a-rdb: use common spi-cs-setup(hold)-delay-ns


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


