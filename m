Return-Path: <linux-spi+bounces-3947-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363B793AE29
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 10:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6657B1C2098A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0181A14C5B0;
	Wed, 24 Jul 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ags9IqPN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC11CAA1
	for <linux-spi@vger.kernel.org>; Wed, 24 Jul 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811389; cv=none; b=k1PX/9FC0/TeiHH2Lctc6gZP0Uquqj710ir0jN+F53Ka3vqUyg+JiEJm8zno94lbTSTo/AIRnSZOEVnccQ82/D5VdVoLKIuoOs64Zw2bC3sLtmeKoNiLurSnWoaumAWhusMCtAdxyqy6yX2rN07VJqrusD7lz6Ca1lfiz3FSQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811389; c=relaxed/simple;
	bh=QW9QEJoFseAPNDbgLfSHhfFaSnhJUShZWSqQyZsIjvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=K1TKL8eXrc/hjwUMhrinLQZdKQVfnYanbje8OenGQA68NjbOV3qwE+FTUc2vq3AVVlbG0gDElNWChGO1PKgQuOnTFH06GXiEvKpIw8CR0eu00LLY2X6Qdo3XnT/Y25HBkSoW5ovEdkFBwZE74uDO6Y+Z7JuSN9Te3/NBpM/m7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ags9IqPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6C43C32782;
	Wed, 24 Jul 2024 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721811389;
	bh=QW9QEJoFseAPNDbgLfSHhfFaSnhJUShZWSqQyZsIjvk=;
	h=Subject:From:Date:To:From;
	b=Ags9IqPNUGlKEF/iihIxkCr+3E4qjREq21tGAQx9WIot1Ev+605uf18Empp4KaAon
	 J6W3+IUpCHPaNThlmVn7keFHr4jlfQj2WXsnUFa9drfX02hBZhbtJHEUl6fC/bFmHu
	 WG5aPUOrPigLjhebigEv0J+MGbJzpecbwzAANu1hW4g4CFoDhtv6GL8XbOc4roZRH1
	 UCbOJ1YJSxjgMn5Pi6qBSo03fPK+QJr4D2mo3lCnRRbLGbMgI3p+1+uONG+Bk8oZXX
	 yNMCGUn1tzDm4zQUn3h+QZ4d/GX4pBeihmlBOdVMgqnZdi3Sh5neas3L8iYv+I6yh3
	 qae1TQZpEQeDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92310C43445;
	Wed, 24 Jul 2024 08:56:29 +0000 (UTC)
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
 <172181138953.1676.16870209755092469163.git-patchwork-housekeeping@kernel.org>
Date: Wed, 24 Jul 2024 08:56:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: ppc4xx: handle irq_of_parse_and_map() errors (2024-07-24T08:40:47)
  Superseding: [v3] spi: ppc4xx: handle irq_of_parse_and_map() errors (2024-07-22T14:18:22):
    [v3] spi: ppc4xx: handle irq_of_parse_and_map() errors


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


