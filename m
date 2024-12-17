Return-Path: <linux-spi+bounces-6079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C469F4ACC
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 13:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FF6188A234
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3734B1E3DF7;
	Tue, 17 Dec 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="q5cBwaQa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D31F12F9;
	Tue, 17 Dec 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437834; cv=none; b=HRRUpkLg0Xf/3YC6/XZzhXJVR0RW3gsxETBhZhDn277B1fBbi3F2wUgdkbsqYsGW01op9NgGb/XUrY1tHAquAxoTJB7wtY/w4Vjcc8ot6OEQSvIqAaZuciHDULr24KzsFNHnzvwsrgA9lLCbiQxTyws5Geerr8YZ+DBZsjCsoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437834; c=relaxed/simple;
	bh=lPr6mApvCQCt0YsoDhRq3ec2KVOt6Lq+9dUBWYQFu9s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=HFEtxno/w1J0R7vQXz+BRPIaM8ISUhdJzEdZW28XkgdYWSfngcwPHmFC8mtqsg+d4IVE14yoXrKQtrcLmupnWk4rTmfvc53Ot3BNQ4Ckj3VziFVRwjLVYcVVxezfQgNbp/JpWyVSSGvfbmvRzEkbJNkoRGJzms/OnvATjVjLrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=q5cBwaQa; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734437809; x=1735042609; i=markus.elfring@web.de;
	bh=lPr6mApvCQCt0YsoDhRq3ec2KVOt6Lq+9dUBWYQFu9s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q5cBwaQaQ2bZFGKO96TAMjxOoTxpDgfXrqk0ba5YR4fKMhoPyZrVUNTkBhhQAx0P
	 +dtCQJ7XMXoEhhXEbmbX2shJCMBhEU9XbToH9JVF1UpDeV0f9vc7ZI77tgjGzdyKi
	 fVtxejDSJvzNmT95kjyo9ykH8owVIZMF1/ttIEW7dw4EY8rdZTATbffydNX4ExgKX
	 LiFpgNusMcjVsqVyYPeNG0zpcsfTRvjZpEEXeZsWFFuQS85I36q56G/uMZTNsMd8S
	 FJdBb6aeHjj73P+X1CLdG1ngfVc5SDymJQ/NxiAp2/6c94TuSKTj49+B3m376Qupq
	 hiPcGTMr3Mdl6W5xOw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.74]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N45xt-1tW53o23Wb-017vYe; Tue, 17
 Dec 2024 13:16:49 +0100
Message-ID: <e29d221e-4ecc-41a8-9cfa-268c45ec9bdb@web.de>
Date: Tue, 17 Dec 2024 13:16:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make_ruc2021@163.com, linux-spi@vger.kernel.org,
 Aaro Koskinen <aaro.koskinen@nokia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241217073133.2908052-1-make_ruc2021@163.com>
Subject: Re: [PATCH] spi: fix reference leak in spi_register_controller()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241217073133.2908052-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ycL0XUfgJpMpTCGLhvPnKqwIE8vBxtHj6gT2EQvAy/BHFUzoAyT
 GDTzZLEmQMWC28T7Jg9P+ZAKAXisatRATDVH0owu2mCgDVEAoyiRXzeCfYUoXmNNLs14Z8o
 MjuHF58AeK/bbF3Dj7JDgK8pf1Nn1tUeH68dsPaAzieRDDxNwyDaF+HMhIdpgwEp7gNUYag
 Vjbike+6wCC2DV8pE+sqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FgCNtYCRux8=;/sN863JG74A1GiBb5PGXzaLKRYb
 E4gieAf8lsxBCZtkryBIiUFvuFexkEHM3OPgnY+gltHm7heMMDeGRe64/Rqps+VbPXP3eVUON
 NoFFTJaJ1dZvIyG9vlO8rE/foRLFunKEq0Fogf4Fw4bMj7Z/TpUeqb4KBr9eIt/Z+JNCxrGaO
 V+1nQE3m+o6HbPoKDHI4UkP21mA8diLbFhWKHeqMw1HZZvF9v+gh+psdoF+jJx5yJPtQZqEGj
 ySWhnK1b/jqy4mm7qs6H4MIy04iXgFXTWNwB0SRjsgz8rAmDVXqTQgmW2Y+tcchmeS1L2H3s4
 +w5Z4Ca8um6rpetcOHpSCVqaVBYohctaQlAgwtypFnF+mY0faBi+KuORZPi8DjsOAZiq3RA5Q
 dcPhIBfgBsHZQy1XFL8bC3VmFcQ1dgJ4LPFUXR6wDvNbzKBgqbYoj1sBxDX7so3hIQcXENvxI
 tR08Mc0ERWDFK+rBPlHCwRfYNqax4SPvxq4WBxCH2KYUbmK1Bg7CbQzSVhtTJcoTxCL5Ya64V
 nZdqMmhQ9wKuSfK28MqNaSWmc70bvYUJiVYaWXCLs96QnA5lGsqs81J/ehIn2n+DyNkbK2kj5
 vhu2QPMhXXYVdey0ir0Gz7D2HaMp3ztTRtQ23D5/IL2kHxvOvNBs4CgrpcJfxRKP1jCmC5hwK
 xUIw9RLSWtrqULKZD5xMAqgO+z3CToEreghJRs9axetTTj61+KSzPWGQ0EtgbDatq03W7fGle
 5w59Fzdm/HJdEiY96Hw6JSfPQDG5Z+iUlhcB+34AtAUVYLVTQc+1q4OZ/Us++zg/zln9L+Zav
 DPbbZUpTGwmdxSHVIKRtXq0kJd9u9wxtYLzut96S+Vkf0s92EGyQ4EW0ank1q0hsjA/XlYCNv
 m22N+e91ecsZn/zTQwikdCNxcrSVeD1R0lc9emkwuMkom75LWw15JS4EvXXORI4ZtkUCSKSjj
 KatzTV/fSa2iy3WG9RIBxLAbxU2pclIfQvcqR2q8wLDKnN43V9ZNb2oFgz19+rcNYkjae1Y4/
 nMzz+a1lVmkWbfTn8fV3xqU9/sl5ifESlKCp1Bep9cEbhjLuj6TL0voJxGusfg2OREb0mRdzV
 xGWYj7Tzg=

> Once device_add() failed, we should call put_device() to decrement
> reference count for cleanup. Or it could cause memory leak.

Is there a need to integrate the added function call better into
a goto chain?

Regards,
Markus

