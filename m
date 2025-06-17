Return-Path: <linux-spi+bounces-8628-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353F8ADDAAD
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 19:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09823BC45F
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE74285060;
	Tue, 17 Jun 2025 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVqY7MMT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8C1AAA1B;
	Tue, 17 Jun 2025 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181559; cv=none; b=gbrhD8L3G5ynOPEAbNhnpuYG8HYx/WApW7x3Al0MJBrKZZVoFSMjRpJkiPoxDVmeVnesQKfMcJacX4+wVBK6/nJ6Qu+Gcv3p1+HUZSK1CLgGUEb/qONHILR+vwbRFMR268AfXSwvVC1lmxPy2ORpaNvkACQIW5+OoqusEHRgbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181559; c=relaxed/simple;
	bh=327wkh+/VeSwFfG4Pq9N5mo4XYFue+NAe59l+/QO840=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glci17NUDU8gseTtQpG3YMZAT2+nJNzrB52FD89BDNFi5n6FKu6ycHGuLTQDy5FG3enH9KcfmJIhgtEC42ho1lsU0tit3YuD6cMiXNFcrPbwX4yYtcyuhs8L/vBHKJAGAOahsSz2mPlRKJc7JginlEaEsPovuTbNC0/MZm5h+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVqY7MMT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d3e5df4785so35161885a.0;
        Tue, 17 Jun 2025 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750181556; x=1750786356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wNT96l/L1TKvL+hy9kvQ/IwQtkX/iGPMeGmWPo89yLM=;
        b=eVqY7MMTMYjVlsSjIo9t0X1iE6m+ydTw1ZP9vRi2ulpqoFTOlbTiw/shmcBR/edJd7
         f2YHwND67EJNgv3bsodnv22lE2XdZVUivoI8NZ97OHeRFNQwYdpNxiXA+im8MU5GLI5U
         wKzLbagYTKOPS30nKzrIiv33Ycoc0KoPzX+vpc17UpuHxFs69u4sKSKfEQj/ruhFs8ga
         +e1ywLtd3/U2Itp0bbxnto5LJ5iHElFSXVBQl1MdxNq1E2KYUVpf7IByc42mM5OwMzZa
         x0484HQiAHaVYadzicg1xR2p+Sit9z126qVWL6oUxeJHGWYUSudO6wgDvgpBRaxyGyNL
         l8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750181556; x=1750786356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNT96l/L1TKvL+hy9kvQ/IwQtkX/iGPMeGmWPo89yLM=;
        b=GHsp8BakHPsCPevLpQdoSLKvZ5V8fpHODqcWszFx496dbMBSQytxAGFbZmA3s3QIcg
         PervGz0fdSBgz6nMrOX0y9ppKEPCEpKpRlV6rPVwMTO92BqIOGIgTWtZX40Tcax7esC4
         9qNoUIglGZRaRZu9ifFaNfE3f0Yf9sDID3M96/y1HEzdI4EpKD8f/5FN9C05VnRCEDvZ
         orjKSraO3NI5lHCvuJE7zmZLGSoRJdy+jfN8JrgcCOiqnEVROjyCuC3sjiYFpEbeMfQk
         4DK58ATOjemBMPxYYJbFw20tDty8GcYB9BF/0/V5MbRX7L2RBRj+/4b7TAlzwgnn90N4
         787g==
X-Forwarded-Encrypted: i=1; AJvYcCWS40Vv/7wK+Di+UzJuFVtbd4oz5nmAG2dWfylbCOyYCDVrjzJ/vuOOCI5Xk4tJ50ekO6mnOO2l8Q4c9A==@vger.kernel.org, AJvYcCWTk+qUSPccuhBXHU665r2fix7mFxuvtOPKvqLhEmTMuEOQXBkbavUS7gpP5fXeWNQs1LRpQva3+IQD/T0=@vger.kernel.org, AJvYcCXGMGbpztjhrPhchrrG2QeK5RMtU2CEvl1wwawpCpm/pPVmf+h6ENt2QieL9XUOwgTAN5UxwCAAJq6H@vger.kernel.org
X-Gm-Message-State: AOJu0YzPS6e5H633eqxf8PSm/J+3yFweQ5iKE25CDFYQ31tD0iAiVP3F
	YDXlSCth0z0r7xaurzP0dp5Y25B+stbLidB1aRqikaRn0YKktsVXFPoT
X-Gm-Gg: ASbGncs0/graUYA0se6wTkG6PSBFDJLc6pES005n3sK6/P0WZHlsW4dPg8LQxONLoKP
	immOZCL6Slbx9vfCUM036AgpHozG/rLBRroFSt/xAdi2NxwHcqd8of0bSxs20XoVwZJal19xC8o
	QoDzdgiRUyuP3ps2joybmea9JELc2BFo54SoShioJZHWDwIaUOs5ejUZHj2m8DhJ9roT64WYjGn
	kCULS+1HFP4aawxHR/udkao/xrufcRqmQk0XnTKSkSwMr9t+Tr613koW0ieamlqUgqNwpDNbJsU
	KyaOaJFpz0bEcVJdb9yTQD3Vkr19plkSluwbfzME097VNz7/6+4af3Q/5MAOfvmwgyMo9tvRDj/
	uWYnhStPxn9o8WDnpmpjvdsvpT6yPVyEMXdFK8NmFa3I6f2+C7CUl
X-Google-Smtp-Source: AGHT+IHv7jLpK3Ul34lwaxNAM1Cqm+lTjV5Yo9JWoxb+xmYRDOcjMKkdxHpcBnPucHEA9I6sn9hdTA==
X-Received: by 2002:a05:620a:17aa:b0:7c5:5670:bd77 with SMTP id af79cd13be357-7d3c6d09a79mr2334127885a.55.1750181555789;
        Tue, 17 Jun 2025 10:32:35 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dce692sm676081185a.14.2025.06.17.10.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 10:32:35 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9BAF61200069;
	Tue, 17 Jun 2025 13:32:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 17 Jun 2025 13:32:34 -0400
X-ME-Sender: <xms:sqZRaIUQeoNORo-Sg8BO-h_Oq5tXXXNa0jYV79jBEOPSbRh4iD0qng>
    <xme:sqZRaMmiYn5tWOXttI6vFmUzqs3n0gy83wQ2OmhdxI_40PuO5PhSWCzYUTJcKId0V
    nm1c-2BamwASYhGZg>
X-ME-Received: <xmr:sqZRaMY97MSR3Ga5fRLYb3kdtLGPzG12DclM4qns-UHl6c244H7W8clnVpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtuden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefgleehteekgfduteejjeekhfejfedvieeftdfh
    hefggfehheeileeihfdtteehfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eplhhinhhugiesfigvihhsshhstghhuhhhrdhnvghtpdhrtghpthhtohepphgvthgvrhii
    sehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrd
    gtohhmpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepvhhitggvnhhtihhurdhgrghlrghnohhpuhhlohesrhgvmhhothgvqdhtvggthhdrtg
    hordhukhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrnhdrgihusehngihprdgtohhmpdhrtghpthhtohephhgrihgsohdrtghhvghnsehngi
    hprdgtohhmpdhrtghpthhtohephihoghgvshhhghgruhhrrdekfeesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:sqZRaHWdgQONcxQ7nHIQ13kUD8EY9n1tQ60GxOqsWbEHg_GHZE2wcg>
    <xmx:sqZRaCntxstgU_tCr0_Y4OkHisP-rVcSJqE96GTsvBb_0MRlkY9m-w>
    <xmx:sqZRaMdseC0jzyRASpIcQ8UsbYim0tpyIspQ38lf4acYWitFupoeTA>
    <xmx:sqZRaEGsEtpyVmd2Y7vb6YWJ1ZIGEX_fWt3ol1-bn_UKXGDzxVlTaA>
    <xmx:sqZRaImKUtP3CYHaC1GhcXMOwYaq6RMJE_sC5VPnyDEzXmC1HWMAftuX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 13:32:33 -0400 (EDT)
Date: Tue, 17 Jun 2025 10:32:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 3/3] locking/mutex: Mark devm_mutex_init() as
 __must_check
Message-ID: <aFGmsXTaVAgfRc_j@tardis.local>
References: <20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net>
 <20250617-must_check-devm_mutex_init-v7-3-d9e449f4d224@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617-must_check-devm_mutex_init-v7-3-d9e449f4d224@weissschuh.net>

On Tue, Jun 17, 2025 at 07:08:14PM +0200, Thomas Weiﬂschuh wrote:
> devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
> marked as unusable and trigger errors on usage.
> Enforce all callers check the return value through the compiler.
> 
> As devm_mutex_init() itself is a macro, it can not be annotated
> directly. Annotate __devm_mutex_init() instead.
> Unfortunately __must_check/warn_unused_result don't propagate through
> statement expression. So move the statement expression into the argument
> list of the call to __devm_mutex_init() through a helper macro.
> 

Given it's Peter's suggestion [1] for __mutex_init_ret(), I think a

Suggested-by: Peter Zijlstra <peterz@infradead.org>

should be added here. No need for a new version just for that. If patch
#1 got some reviews, I would queue this in my lockdep-for-tip branch.
Hopefully these will land v6.17.

[1]: https://lore.kernel.org/all/20250204090106.GP7145@noisy.programming.kicks-ass.net/

Regards,
Boqun

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  include/linux/mutex.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index a039fa8c17807c700d3b61193feac0418cad1243..00afd341d293ddfcc0a427b576efdce044955e38 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -126,11 +126,11 @@ do {							\
>  
>  #ifdef CONFIG_DEBUG_MUTEXES
>  
> -int __devm_mutex_init(struct device *dev, struct mutex *lock);
> +int __must_check __devm_mutex_init(struct device *dev, struct mutex *lock);
>  
>  #else
>  
> -static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
> +static inline int __must_check __devm_mutex_init(struct device *dev, struct mutex *lock)
>  {
>  	/*
>  	 * When CONFIG_DEBUG_MUTEXES is off mutex_destroy() is just a nop so
> @@ -141,14 +141,17 @@ static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
>  
>  #endif
>  
> -#define devm_mutex_init(dev, mutex)			\
> +#define __mutex_init_ret(mutex)				\
>  ({							\
>  	typeof(mutex) mutex_ = (mutex);			\
>  							\
>  	mutex_init(mutex_);				\
> -	__devm_mutex_init(dev, mutex_);			\
> +	mutex_;						\
>  })
>  
> +#define devm_mutex_init(dev, mutex) \
> +	__devm_mutex_init(dev, __mutex_init_ret(mutex))
> +
>  /*
>   * See kernel/locking/mutex.c for detailed documentation of these APIs.
>   * Also see Documentation/locking/mutex-design.rst.
> 
> -- 
> 2.50.0
> 

