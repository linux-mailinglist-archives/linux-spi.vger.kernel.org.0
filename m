Return-Path: <linux-spi+bounces-1143-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FA84CA09
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 12:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D572890EB
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 11:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902661BC40;
	Wed,  7 Feb 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+MfeyCX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E81B816
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306994; cv=none; b=XkDT0Le1wl/cc88Iv68Cfadi7EueVNOwRtvshBsm4ir5ubt2qjtkBR87z5GnwTywiW61mSAD5WUdecpeGz+Uov6EqgAwY8J9OW/mUp33lfD7DolyOpAeZoJEJxFffS/yADkVLFshruuVqRhREfhKrO3tusyWy3rMnDLQZ5bx2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306994; c=relaxed/simple;
	bh=KI19Iq0oYpqhGMk2O0uDZrrhzEypzHLoGmrmz74gepo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nN6D+B4JQUmY9fi9WgRkMWG37mv2JZkqO2dqKSsBwAcVe/sQDchlqogpegNYqBcr0ukcwbxfxQOTtM2MPz164DdjaDzy/8lkLQso4AauKXoTgodw5nJKN+0B21cZcMr50QMAdkXOd+c23c9xtGgPXa0kSAVAcVyTWYDTO9G5OpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+MfeyCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9475C433C7;
	Wed,  7 Feb 2024 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306993;
	bh=KI19Iq0oYpqhGMk2O0uDZrrhzEypzHLoGmrmz74gepo=;
	h=Subject:From:Date:To:From;
	b=d+MfeyCXIv05VkjKaQkOWLVXXRcbwDx8kgKBCUhB7dfxjZjIXbgXa77wa75v1S2mS
	 KAmO70T8VJkGZ2E2HDy5nnIK9ZfRVc56FlXCqiBxBS0Huhdp5Mzn50u2dZka6zFZPA
	 74yVz1M8P4Kud39CWYNZaMm40trLGsDeWrO+U3BFMLNNozz1c04pR7ayKbUSMs/RJk
	 /eXHM1N2pg0Oak7lyc651lo0fhQdevkBx+dMIgy5vvP4reIL3mEzjUyIUdXFz0wR0/
	 UdKZAeccUXJbapY9bJJnpK7tJfZXAxMA2VbvzQ5aKR8iauD96EysbyXx6Q5dLOMJtq
	 bg6JKP6kB8jXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCA1EE2F2F1;
	Wed,  7 Feb 2024 11:56:33 +0000 (UTC)
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
 <170730699383.26418.15995217285970031677.git-patchwork-housekeeping@kernel.org>
Date: Wed, 07 Feb 2024 11:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: s3c64xx: add support for google,gs101-spi (2024-02-07T11:15:12)
  Superseding: [v1] spi: s3c64xx: add support for google,gs101-spi (2024-02-06T08:52:34):
    [1/4] spi: s3c64xx: explicitly include <linux/types.h>
    [2/4] spi: dt-bindings: samsung: add google,gs101-spi compatible
    [3/4] spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep accessors
    [4/4] spi: s3c64xx: add support for google,gs101-spi


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


