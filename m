Return-Path: <linux-spi+bounces-10767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED219BF9F22
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 06:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA0B188F1BC
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 04:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA22D0607;
	Wed, 22 Oct 2025 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="eICJQYbe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80D10A1E
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107659; cv=none; b=VffUbMobPSQl1qEcEfacmrE6w+kmt/PcYMJTs1ym0h8u3s0oKi+maJOyd3lINqptC12ICwrZ+qkj6TlDo7Ocz3wNfGwBOt74BrnBSkRK6W+FVm5xWx5pOmqukIievnottmXgTX57bxmB51wyyRhjDtdbBhAjl5g/lY/o5NCJg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107659; c=relaxed/simple;
	bh=Ta3vLBQn3sKyycsd6zk6kL1yNYlGExTdBO+VCjlMbt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pjy18q6uTWNEeUpg5Xh9MkNlNRSuEmjMopHMtwAZTZ7Dmi/+Hm9VkSP5IMJn65r1KXNnuwxAaEyw7VakafczyjIMCcW84N5+Z6EAaXOudOorIZGJM58NM8Xqw81JY7N6iwQKsYs4wsS/k6DQk1fqpOqP6wjV03avtAJpw9fYgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=eICJQYbe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b556284db11so5333598a12.0
        for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107657; x=1761712457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppwCPMx8V2Sf6deae1nCYy7pnPOnc4IDjA11Y0/2goo=;
        b=eICJQYbejhi+Edhn0HQlKs6ymsdpqS4weM5zk3/8ogTuaIZtgsTy4XqdM9ErgYlS7L
         XdWfRF9iHSXnc4eOREt1nh9EA7rX/Bh45ap1T6JAtAUSjkGoNB1GT6GniFsZ+OYfrJbC
         ZRfl9yq+D+fvJj6zkasVTRxPAHKMjTIYqhjh+Ur4K98WtV8PqEkIJRDS1w3cFOOxlRTS
         QVBLfAQAMUut1bR/6LF1N4ETkuCZIqyMR9+8c8652kYMbi8BXqdjzClgNqlkcJ57Wpbn
         fNeNRTLLlK/jGB8r09QDZK+9kAchioCe0FoAnWc+x50/TGfe7cH/fdZ1xz2A/CS4dFjL
         /PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107657; x=1761712457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppwCPMx8V2Sf6deae1nCYy7pnPOnc4IDjA11Y0/2goo=;
        b=KxEDFDt0wRNfZEAVAVIj3h0SGOh1rs6HH2FWi3CmVmJJL91ZF3xYsYl5YM1qdChCAD
         Tr1MffejO6CEU3rrMUy4L9U2vok6Xl+CFLIXQvCrUJ2zWE0/gIX1pF/Vj76T5B2j3qkK
         0q//fzvQ0UEYnAS3BIqY8Zs3kK4VcHJzEgMgL9eEu2wp9NJSaTRe4ief5TkYqhmezLu2
         GWulFEVxoUTewFThe7tGLy3No00QBwAXc+vUMHXH0K0rI0vxrKcv0qo8ZluXfTxha2RL
         5MTjXtcTw0cX5/u1qZnDMSOddQt1vLTk6f0cK6fz9uuMPIMO57OZPw/BH4QR2+nDkUl8
         YUvg==
X-Forwarded-Encrypted: i=1; AJvYcCVfEDmpgZpG4lN/IWciQnC2dzLdIn1OJobFcfi+N+RPdEnGhxj570LEwmTn0ieAfTcWjLOAzU7B1/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+bkvxbgpG1H3611XvZTRwtCtQPKX8726xMhn1QR3khLuz6sM
	0jh9W1113FM/cjz/zpHpdny/KT4Mt57AqMEQ7XqBGh6+YCb0hYGeGghAzx7PrMpWIC4=
X-Gm-Gg: ASbGnctoL1M+y3NPisbPG9gzQl/2ZF4eaPhbVzUXabN7qfdTOobdjw2R7PKUvZvmvao
	LOx+7lvPtzcfRhq2OrbIsyGCvsDqHzUSkwKEr05gkKl9DJM8e7IfjIogfa2I7LzN2r08NllszdV
	cv+CC/XIdGJ6IurePnYEs1wOTc+cTLqOeV40pLZch2xWDaBcEwjOx4Y/3FS9OnesoOcblBHpjsT
	Ywi5NlNdpzDwH9dj/36iq8ZGS7l6pQrTvj9BWluDyrtCqsGIMVZnxTOJhPLLjflZbqGehJYcene
	C3fRY8YbbB64kxduMlztnP7LWHt1H1Zel7Dj+9Yz/DAmnR3QX8eT/hca5aVeFKcO1nZ0c1TiYJE
	EQ+lFxa45yhnIGOqj1KfQDuUKqclmJBZQdJ45g6QjMrlIIzyDYvcECNc64Gz7yBgXNGqA0sc3e7
	YgkgQ1Ud8Tv8X0
X-Google-Smtp-Source: AGHT+IGRbL8alcY98vwlpMmB68/E/fiZ8vvTYnBqywFldOw2mBZIi0C45CU+Ljv9QC55tUOEBjim+g==
X-Received: by 2002:a17:903:1d1:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-290c9c89fd2mr213302675ad.4.1761107657244;
        Tue, 21 Oct 2025 21:34:17 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4cdsm126257025ad.97.2025.10.21.21.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:34:16 -0700 (PDT)
Message-ID: <ba01b2a5-a04b-4a6a-9257-09f38f2ba5ef@riscstar.com>
Date: Tue, 21 Oct 2025 23:34:15 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
To: Conor Dooley <conor@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: han.xu@nxp.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlan@gentoo.org, guodong@riscstar.com, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-3-elder@riscstar.com>
 <20251020-blinked-primary-2b69cf37e9fe@spud>
 <b28d71c4-d632-4ee5-8c4b-270649fca882@riscstar.com>
 <710c36f2-3551-4738-a965-f1564416348c@sirena.org.uk>
 <20251020-florist-campus-a397bf94d129@spud>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251020-florist-campus-a397bf94d129@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 1:39 PM, Conor Dooley wrote:
> On Mon, Oct 20, 2025 at 07:26:17PM +0100, Mark Brown wrote:
>> On Mon, Oct 20, 2025 at 01:06:46PM -0500, Alex Elder wrote:
>>> On 10/20/25 12:39 PM, Conor Dooley wrote:
>>
>>>>> +          - spacemit,k1-qspi
>>
>>>> Are the newly added resets mandatory for the spacemit platform?
>>
>>> This is interesting.  I never even tried it without specifying them.
>>
>>> I just tried it, and at least on my system QSPI functioned without
>>> defining these resets.  I will ask SpacemiT about this.  If they are
>>> not needed I will omit the first patch (which added optional resets),
>>> and won't use them.
>>
>> It might be safer to describe them, otherwise things are vulnerable to
>> issues like the bootloader not leaving things in a predictable state.
> 
> Yeah, if a linux driver requires that a bootloader set up a clock or
> de-assert a reset etc, then the binding should mark them required since,
> as you say, a bootloader change might do away with that de-assertion.
> Additionally, the stage doing that de-assertion etc could be U-Boot
> or barebox, which import devicetrees from Linux, so making sure that
> the resets are present has that benefit too.

OK, so the resets property (added in patch 1) will stay.  It will
be defined such that it is an optional property, and only when the
compatible string includes "spacemit,k1-qspi".

					-Alex

