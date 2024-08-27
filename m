Return-Path: <linux-spi+bounces-4341-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB14196160B
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 19:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E8AB20CB2
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12BF1D0DC6;
	Tue, 27 Aug 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ay2F/mQu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD32126F1E
	for <linux-spi@vger.kernel.org>; Tue, 27 Aug 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781390; cv=none; b=G8NqPXiQUFMl8jc5SA6zdygHFlP7nua+AgvNUFfOlmAwHW3STc4PT6AgXNLPpicBINXNeOOYc+vklhv5yWEm2PRTYmms6p01fQd0b9jVTrU0j7p8wQppJsF8QnvQNXycj4ktoTRpJOd/wTSBNTXhWxWk/64rZ/zLs9m21jbPEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781390; c=relaxed/simple;
	bh=cDaQJnvTaDmwMzleR/ChPiRrfkU6ssTE2udQ28lYaiY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=akzmc1kw1tywRkpKnBf6WZ1/wQ4O+Lg+p/6SMsXyMIY+nav7w9EE+jG2eC3e14LuMAdMNOS0l+eXkvGP1o+vzsyOnszKhaLJtjcopYRn2UjtykO1cq3Lei+Pm+Ca9b8Du6o9dDiGt/DDyrW8Eh/zc2tHx2htdGOvzRzSBNSHz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ay2F/mQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C2EC5810D;
	Tue, 27 Aug 2024 17:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724781390;
	bh=cDaQJnvTaDmwMzleR/ChPiRrfkU6ssTE2udQ28lYaiY=;
	h=Subject:From:Date:To:From;
	b=Ay2F/mQuCtC+NoWOfHkQOEGJO5hIqLH616Ysv5w6ne2zYFHCGc6GTb5hYnjO5uyHY
	 XIZlZcf1mFXECBlaUuWlEv/TPcNbe+NxJdHMIjqPYhwC3cyU/9fSzGn4c0wfROkjyF
	 WWgh0c8CYUOZ81dMn9403w4uY77tZuU9cc6dVx+Ml88LUlY0uO83xW8j0X0E3dSul9
	 qyGAtUD527zmjZxSGoAFxGG65eK+RLvx0Tg+JBuXLTFDch3Foalo26Fnh4CYxnDFUe
	 g4q1qKol8EM5kFD2apNfIG9IVAaOjgFS4WBfIZN6ENVzvvGDx6Z539bgjgYrBCUkYT
	 E1MB3Jz1yTkuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2F0B3822D6D;
	Tue, 27 Aug 2024 17:56:31 +0000 (UTC)
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
 <172478139026.717901.15938216471921406302.git-patchwork-housekeeping@kernel.org>
Date: Tue, 27 Aug 2024 17:56:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: rockchip: Resolve unbalanced runtime PM / system PM handling (2024-08-27T17:11:16)
  Superseding: [v1] spi: rockchip: Resolve unbalanced runtime PM / system PM handling (2024-08-23T21:41:56):
    spi: rockchip: Resolve unbalanced runtime PM / system PM handling


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


