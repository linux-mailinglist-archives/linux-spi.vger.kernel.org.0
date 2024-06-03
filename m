Return-Path: <linux-spi+bounces-3203-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC38D884A
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 19:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2247B1F21FB5
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8607137923;
	Mon,  3 Jun 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVZ00z7/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BCD7E579
	for <linux-spi@vger.kernel.org>; Mon,  3 Jun 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437412; cv=none; b=a33uIb5oXy/hp0uYoQqb+q9nlQfMtAQNWML8gl0Ov6U26LKWhwSoVECZc7EsoA4kxeXgCuBFJwX7u0Fq+teprAEHfiscUC/e/F8HjTzsaeeGilb1aQsF3WajSQuRokCRAdbFKjrSlbqvSxJyq15MNnUNX+8NnG2VrjvopGUtcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437412; c=relaxed/simple;
	bh=FvFumUmjRdteQlNOZ7C+GszLjc3bjOUSNq3m8q0Yteg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gGsikyW21k6Mge/NUj2J4HqHfFXLbyLs8b1KZlV6pftPjqdqTkEUS3u/D3oyahglv/d+djr9LUo8HGkydqvq5yJqxKxh6Aw/c1+z8hxhxP+SFWPLgqQT5Sh9zz3zRvXu/1sgTMwrSnoPZAslHV3d6QHzJ2A5LGCnqWu+6OZjH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVZ00z7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 484CEC2BD10;
	Mon,  3 Jun 2024 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717437412;
	bh=FvFumUmjRdteQlNOZ7C+GszLjc3bjOUSNq3m8q0Yteg=;
	h=Subject:From:Date:To:From;
	b=nVZ00z7/YfXsmIo6wBulW3yfcl/MWtOz3IRlqiVSKfzet9BlN6JltMCoKPJt6Mha3
	 qeUimjc4r3ZrSnA9f4ZUCk1PQE/iBdsfyb/GN5ZWFv+Cw4DsLGh6gBAODJONjQSYhM
	 y/ZhEaqXDj/bfse7/Jzr3Fls/SdJWwNltPgFQVWiWhdMPSzoON7UOX8ALEB8eQ3XCC
	 O33tExYHUijEarLbL+ORnlWjtunT71FCx4ejwCXOLgSAIR90xoTOxvXrn1zLEJR6sz
	 H48VQHoLvC2fc53o3lOhR6p+CUuyf4GV45qFc5qOSp0o5FWyTiyGYX/WvgfawSVfun
	 OsqMdj9h17wqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35A38C43617;
	Mon,  3 Jun 2024 17:56:52 +0000 (UTC)
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
 <171743741221.31987.4066626523586850201.git-patchwork-housekeeping@kernel.org>
Date: Mon, 03 Jun 2024 17:56:52 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema (2024-06-03T17:30:23)
  Superseding: [v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema (2024-05-31T12:29:37):
    [RESEND,v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


