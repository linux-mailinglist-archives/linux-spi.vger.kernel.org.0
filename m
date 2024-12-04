Return-Path: <linux-spi+bounces-5917-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE19E47FA
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 23:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659161880422
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1C1F5417;
	Wed,  4 Dec 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6d4EGvm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5421F03DB
	for <linux-spi@vger.kernel.org>; Wed,  4 Dec 2024 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351857; cv=none; b=AizEi8ZB6eM9Pk0yTYTOSRhScUzmRDBGv8KCtpRZINr3yhun9yy6WftjmQlHpOToZw3EnxWJ0CdXZST8hCuEG5tb9appH1Cx0oPqoxt0/XV+lA1Gj+Xr8S7iVMWljRfeog79PIUPKICplT6+l3DFh6rupvj/0NdCYhL+jC0/SC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351857; c=relaxed/simple;
	bh=POdnmzd1BwpN+rTYy9qwuw16Q1+HWaZPsMmd69hHKmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwLmfcEjz2iifCYHsfA88CsKBugPOQGagg+mHI52f18iriE7rmtGYzfMpz1w08Z6/msjP+R/ppGB/u/oMZ56d3hF4OeYBVFVVfq8MGIe4ROuZmgFSC1zMjUSW+Hau4I4YR6lOovWjuxk93eGr+tZZhNJgPegoM1K8mtxKswvWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6d4EGvm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e1be0ec84so385915e87.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Dec 2024 14:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733351854; x=1733956654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnWatFIPmnccGlZwUZNxD71tRzMsuLeasLd0swmh5OI=;
        b=n6d4EGvm/qBFEHJU0A3Vp+C4yF3YYuh/+kHuMkbyfLFp7d4iXC9C6mHD2kpXFU5IVQ
         Ell8C/Z/K5EaOCBCcPMRo439Ln29OsM2hBlPGljOztrG+Z5EPGF+qC4tzlj+oUjCD70u
         sPP4if+1JQhh6oIVd/V1IE5W9vIMz/iCGG5lCPY9YC8xAx2RnDpoMadLOePiO3BFd1tC
         I2/83n45anhRdAZK7ZRb5MM8eZkTiuJoK1AxuVgznpA56dylyblgAejAFWtmzYrz6bV4
         vkhHx7MGLmC0cdcY4BS4jxFsIzJ2UaMca5SKW0hdvTkNoImr646h6b2dTTcd3v/lRWTM
         cFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733351854; x=1733956654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnWatFIPmnccGlZwUZNxD71tRzMsuLeasLd0swmh5OI=;
        b=ndRawonIoUJNjlq2EhOzHqJm1t0OxDMow5vCfVj5NK34MRED0uGw5SUg0wT/naqQS0
         4blN1OO35MnNnQmPxTmuhKedh/bSZOe26Msm6NHSrQi7KBZdb2Fc4vGsDN0lufth/Spj
         B1USCei54hFyw6ow2wq9+7qdT4hpyOdtYXxGN7f7rpamI/1EOR2tUmh+CAPXPH9fI3UV
         kgt6xhPCcpNcDsU8fNa2b97vJ1Bwz2O58mUJxGnWKZhjE1meCzwFG54q8Q0K5WxIpnEm
         15HZiSg41byPW+aO7MOzKlv4+u5g+JkDu29dKgz5x5VrNh+ydlUgFjvL6Y9pg7Io5o1J
         eSUw==
X-Forwarded-Encrypted: i=1; AJvYcCVaADfgQdMGq9OxLqEEwqAt1SYhvvTaVuLXHD1bHvdDt13Tk2A8xjztTgATMlxuL7UUT+v454eamMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1gL+dFIokRFYFspDkZvLQmvOb1PiocXD/LGaFw5/fjNOWxr1
	feQz7BQuXZGsTXo19xJbx1LJuuTKFDTRq4l0g3WPqvw9IP6ygvoSxePnT8zmkUg=
X-Gm-Gg: ASbGncsF7jO3JdvZGJf88SHHFGzsKPe7uyw5O1TrzW6A07QdVpa0pqQc8TRcsMPnw9B
	ToiY/hTz4SsS+JOiG93btrW/0/94bQtYr4Cp7fwykeSW18e0dENNGLEVF/18KOPe4pMUx4I4hyq
	miP6RPEhkCsC8WIb1x+QaN42z7Zprr2fLhLRzsG/1aQZrDUfEUaiLEw49Jvh570zaU22A5hMBtt
	+P2mVxcLVSTE1Sk2nXSqNp2h5C6BqAjwVdn/vItHO4ojK9WFLGu9gUTqWo1hhAhqnX3hA/3daW9
	IN6TW0+YN5zVUM1RO4fqbr2uXrvwUw==
X-Google-Smtp-Source: AGHT+IF9ZCG3qMcJKun4Nqjsn74bToQ1plUYb38GzwepHbZ/WeGz6MaSKqA2QFB+Dtkj7t4l5nk2ZQ==
X-Received: by 2002:a05:6512:3b23:b0:53d:c2f6:8399 with SMTP id 2adb3069b0e04-53e12a35234mr4334401e87.53.1733351853604;
        Wed, 04 Dec 2024 14:37:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229c2386sm21821e87.215.2024.12.04.14.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:37:32 -0800 (PST)
Date: Thu, 5 Dec 2024 00:37:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: kernel test robot <lkp@intel.com>
Cc: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or, andersson@kernel.org, 
	konradybcio@kernel.org, johan+linaro@kernel.org, dianders@chromium.org, 
	agross@kernel.org, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, oe-kbuild-all@lists.linux.dev, =quic_msavaliy@quicinc.com, 
	quic_anupkulk@quicinc.com, Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Subject: Re: [PATCH v1 4/7] soc: qcom: geni-se:: Add support to load QUP SE
 Firmware via Linux subsystem
Message-ID: <5sni4plocjjtzdijtmlxnipthpfz4w3x27th3mergdhhaqjs3y@aqyngjkmg33h>
References: <20241204150326.1470749-5-quic_vdadhani@quicinc.com>
 <202412050429.SJvNsU2f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412050429.SJvNsU2f-lkp@intel.com>

On Thu, Dec 05, 2024 at 04:19:25AM +0800, kernel test robot wrote:
> Hi Viken,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on andi-shyti/i2c/i2c-host]
> [also build test WARNING on tty/tty-testing tty/tty-next tty/tty-linus broonie-spi/for-next linus/master v6.13-rc1 next-20241204]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Viken-Dadhaniya/dt-bindings-i2c-qcom-i2c-geni-Document-DT-properties-for-QUP-firmware-loading/20241204-230736
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
> patch link:    https://lore.kernel.org/r/20241204150326.1470749-5-quic_vdadhani%40quicinc.com
> patch subject: [PATCH v1 4/7] soc: qcom: geni-se:: Add support to load QUP SE Firmware via Linux subsystem
> config: arm-randconfig-002 (https://download.01.org/0day-ci/archive/20241205/202412050429.SJvNsU2f-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050429.SJvNsU2f-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412050429.SJvNsU2f-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/soc/qcom/qcom-geni-se.c: In function 'read_elf':
> >> drivers/soc/qcom/qcom-geni-se.c:975:23: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      975 |                 *phdr = &phdrs[i];
>          |                       ^
>    drivers/soc/qcom/qcom-geni-se.c: At top level:
>    drivers/soc/qcom/qcom-geni-se.c:1268:5: warning: no previous prototype for 'qup_fw_load' [-Wmissing-prototypes]
>     1268 | int qup_fw_load(struct qup_se_rsc *rsc)
>          |     ^~~~~~~~~~~

This doesn't looks like it was properly compile-tested. Please always
make sure that the build cleanly passes "make W=1" for the changed
paths.


-- 
With best wishes
Dmitry

