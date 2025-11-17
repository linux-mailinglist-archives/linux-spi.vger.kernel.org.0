Return-Path: <linux-spi+bounces-11258-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AA7C64C89
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 16:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 650BA366E8C
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB112F6929;
	Mon, 17 Nov 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS9XMW79"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1246B33769B
	for <linux-spi@vger.kernel.org>; Mon, 17 Nov 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763391485; cv=none; b=aAPnDDhl2179BanjliwuN2oE46YjerAMCI4J/0I8mbmiRVTsQrfmXMAOaNn7iPCuLKyfxFZcvToyVIc4iA3M8Ke6eFhU4yn3XaRjSBtMC9i6BdQPYIYr1m3sjSGUnwyqfMKjeLoZV+SSgG1eEknx5jrOsYoJ35GBjagoyFKZloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763391485; c=relaxed/simple;
	bh=rPRV4z4sRzA0mEu5CD9ews2pa4XkSPICLmf9KkVrNic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=edRuX0I61DPoDMZk+iHMHp4WyacmGDVi7z/TdRhRxo49haO8AWC4q2Uvv1uusVFbxDoy5QuOi6sQbxhGXWF+gilVWUV1O+o7OQuEmDPHKZFGIRd6if/+sUHlBtY11J0i4myCWj/vH+Xcc7vtAHWdjoy0zKf4JZqnxwovdjmOMjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS9XMW79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C43C2BCB4;
	Mon, 17 Nov 2025 14:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763391484;
	bh=rPRV4z4sRzA0mEu5CD9ews2pa4XkSPICLmf9KkVrNic=;
	h=Subject:From:Date:To:From;
	b=eS9XMW79RBhdQu348fR+9k67A/5sTbCqmMTYFK7gRMhwZfjIxflQ/bTkJb0Bz4SuQ
	 1ZnUVQkwMCczUat83AnGnQWMIhGZXAOgEET2HkYXtmrLy+bthhZCJnSPPKJhAb0RcL
	 bmaPQT5bkML9/fiT5UolTDIffYF+C9b8gAqGXNdkSvXvjqGbzLwSWAEKoPaZvYgbt8
	 Uc0507vKRbI+8RSoVHxg2abM5Q3UURN5NT2VEEZc0kYCl4OKW+TSvPGdFqmkHxXLxL
	 HHnEq4YvqLG/xxpnE//kqWKyHaqusb9pnM+77NfdUFBpBVrYlpNxw55o8XNwdZvvOl
	 5CZpgrT4lOJBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 65FE13809A01;
	Mon, 17 Nov 2025 14:57:32 +0000 (UTC)
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
 <176339145108.3351799.2836903030672305146.git-patchwork-housekeeping@kernel.org>
Date: Mon, 17 Nov 2025 14:57:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add support for NXP XSPI (2025-11-17T11:04:23)
  Superseding: [v1] Add support for NXP XSPI (2025-11-04T03:07:35):
    [1/2] dt-bindings: spi: Document imx94 xspi
    [2/2] spi: add driver for NXP XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


