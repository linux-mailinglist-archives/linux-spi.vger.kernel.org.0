Return-Path: <linux-spi+bounces-11211-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7371C5D317
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 13:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537333BD72D
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04BA23EAA5;
	Fri, 14 Nov 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDemqVZe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEEF212FAA
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125062; cv=none; b=lPE9dblUUwX3lTWFQBG6kMW9cRBMm4a1hTrsfucoyI9wSMlg/+I/oMqfBzQHVLpNReco/zdQcQ/quMs7giN8qf3+Ji8sqtCFe0pA7d3qCv+wsfYR5OevVZ347oRGk9Hu3XaY9Bdcrfkdux+7RWR99oObPLvsBuSspqMGmucu/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125062; c=relaxed/simple;
	bh=Gqbnhb2XAONzt3f69qjHP0u2ET29RtNRQlHpUiI4S3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mVsSxS7qCsKbGWwsFlDCAeG/nkSJRN6AfKLhpUcgZP4oUqrYEAxYTkr/SpsP9wEb2IcQQXBWHhmr46CQX4PJ849vuhQngZ2g7mN9OAd04qXQdwu0o6mQ4Xr7sC9ok1JMqUioExBHQtF7mB0N26WM826JO8Eqh+KhYv62+rpsTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDemqVZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20453C19422;
	Fri, 14 Nov 2025 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763125062;
	bh=Gqbnhb2XAONzt3f69qjHP0u2ET29RtNRQlHpUiI4S3Q=;
	h=Subject:From:Date:To:From;
	b=uDemqVZe7FZo/qs59JYsunM3bz1MP/8OdwmdeF0RwOzeICTs6N/XopGq777k9s1yQ
	 6aaLa9e/tggjYrV4BGgkLi5KidkH1yyarkRrOweLSpqgXV0EZy54hcdos4lM+2Y6rw
	 iC7fdzgB0DT5VpKUt8m6C4sF4RfL3jrIso8BUp6yyQLptf/MtjfHlWEZt39dTeYk/f
	 KgJkaTWfvLPxohglmNfN9n99gNk6hxBMLwlwBP/emUAqYEUOkPQzZSpt2x85w71SJ7
	 Rx+yaHwiiRqQnmABWsaAjd4htIrdrbp5qHA1za6063g/XfYOd5cW3Z+PyFGoep5cou
	 YcTO92C8o8Aew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1DA3A72A60;
	Fri, 14 Nov 2025 12:57:11 +0000 (UTC)
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
 <176312503054.1640906.15344905212716262053.git-patchwork-housekeeping@kernel.org>
Date: Fri, 14 Nov 2025 12:57:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] arm64: qcom: add support for Arduino UnoQ SBC (2025-11-14T12:18:47)
  Superseding: [v1] arm64: qcom: add support for Arduino UnoQ SBC (2025-11-06T15:31:14):
    [1/5] dt-binding: trivial-devices: add arduino spi mcu interface
    [2/5] drivers: spi: spidev: add compatible for arduino spi mcu interface
    [3/5] dt-binding: arm: qcom: add arduino unoq codename
    [4/5] arm64: dts: qcom: qcm2290: add uart2 node
    [5/5] arm64: dts: qcom: unoq: add dts for arduino unoq


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


