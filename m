Return-Path: <linux-spi+bounces-1863-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E976387DFD8
	for <lists+linux-spi@lfdr.de>; Sun, 17 Mar 2024 20:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F031C2061B
	for <lists+linux-spi@lfdr.de>; Sun, 17 Mar 2024 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138F1EA84;
	Sun, 17 Mar 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPd2T1E8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174D1EEF7
	for <linux-spi@vger.kernel.org>; Sun, 17 Mar 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710705379; cv=none; b=D16QTCJDU65ZWad6XiLEltSUvSQDPmz/o6iL1LxyueABy4kahfkkllNWI5/RJA+zuaIyp/KKsVgG05Hyl+Hps7j+epYFOCK6CFZiYazgXTBdi9jNZV4gQLXPA55J4LIZOEtqm2GL0LAkdp1Ru08s1K4t/sVH6HDPXzI75gBlVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710705379; c=relaxed/simple;
	bh=jyl5CrWgijm9M0p6Opn556afPODIAYaF+t9AicWujLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Q2xQuBlHn1jD0gbzw4JHbfbrlejg05g+iXovcNOUi29NPLqWqp3l9f3+Ki6DG8glYmcNxvxPVbvH8YEJ42gwqPjNUTr2HFKIla+A5/dL+OK3ZfPbQT4uYHuuqufU6WAxFzZtOpAMOVDvz+qZzVonlz5ouDtUiheJxlWa6kMPYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPd2T1E8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B636DC433F1;
	Sun, 17 Mar 2024 19:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710705378;
	bh=jyl5CrWgijm9M0p6Opn556afPODIAYaF+t9AicWujLk=;
	h=Subject:From:Date:To:From;
	b=BPd2T1E8ToE22yziGy5zUUrHPW5P5q498OTjnRf5a9SRgJzCo6l8J04+7bh4V6ym0
	 yos+Uo5qxqigMaegdkZk/DMUmbjGcdWYdY9j+cgX7bHPlWXjQaQam58RlBYK6Un2WL
	 OxJBq/pE5qDlh7k2bq8Eahi8RlGnUeX6E5/MvHfovPsKTNVxbLhOkeOfi8I+4AfRpo
	 Em9aKP3nNub4qRxhb+miUE/WWIgjG8mrXw9HNDBZxmQpP4e1eajO/TcHsEld4b2fUy
	 uL5mr5prOTnLAX3juOwSv53i7SKs8FRPFwvZxv+d0dJf5oJt2sLr+8A72jvSnlnAkc
	 nU0Mw9tB2cu1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D5F3D95060;
	Sun, 17 Mar 2024 19:56:18 +0000 (UTC)
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
 <171070537858.1126.1989611443999191066.git-patchwork-housekeeping@kernel.org>
Date: Sun, 17 Mar 2024 19:56:18 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] misc: Add mikroBUS driver (2024-03-17T19:37:08)
  Superseding: [v3] misc: Add mikroBUS driver (2024-03-15T18:48:58):
    [v3,1/8] dt-bindings: misc: Add mikrobus-connector
    [v3,2/8] w1: Add w1_find_master_device
    [v3,3/8] spi: Make of_find_spi_controller_by_node() available
    [v3,4/8] serdev: add of_ helper to get serdev controller
    [v3,5/8] regulator: fixed-helper: export regulator_register_always_on
    [v3,6/8] greybus: Add mikroBUS manifest types
    [v3,7/8] mikrobus: Add mikrobus driver
    [v3,8/8] dts: ti: k3-am625-beagleplay: Add mikroBUS


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


