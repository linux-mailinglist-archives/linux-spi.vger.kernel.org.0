Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBB1934F3
	for <lists+linux-spi@lfdr.de>; Thu, 26 Mar 2020 01:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCZAVe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Mar 2020 20:21:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:17738 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbgCZAVe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Mar 2020 20:21:34 -0400
IronPort-SDR: 4/ITQ7ko9E83a+DKxOdi/6YmLhOiDG7zqNHkuDIwflM7bFc07NPza/64g82vce+v6UfHlF0p3T
 gLnvLPJ9Innw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 17:21:33 -0700
IronPort-SDR: Wrt22mJixHrSU9PzOZGj0GdTvXxmLuTjpMvFhJqR6pQgwoacV8M9CbnT4plSPj4Dxd7Q5ECS0z
 EA1scJfgDWHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="420502569"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2020 17:21:31 -0700
Subject: Re: [kbuild-all] Re: [linux-next:master 1837/11710] sh4-linux-ld:
 cannot find drivers/spi/.tmp_gl_spi-mux.o: No such file or directory
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "lkp@intel.com" <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <202003260124.NDYYFnCI%lkp@intel.com>
 <3ec603f5379aafd36f80490ef78108b225eac030.camel@alliedtelesis.co.nz>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <f8241a5b-b9cf-5d85-bdf8-b22be139ee50@intel.com>
Date:   Thu, 26 Mar 2020 08:21:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3ec603f5379aafd36f80490ef78108b225eac030.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 3/26/20 4:30 AM, Chris Packham wrote:
> On Thu, 2020-03-26 at 01:38 +0800, kbuild test robot wrote:
>> tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> master
>> head:   bfd7a248502373da8b1c8eb0e811fdb19cc3f8b6
>> commit: e9e40543ad5b38b848879768359fd13650529961 [1837/11710] spi:
>> Add generic SPI multiplexer
>> config: sh-randconfig-a001-20200325 (attached as .config)
>> compiler: sh4-linux-gcc (GCC) 9.2.0
>> reproduce:
>>          wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>   -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git checkout e9e40543ad5b38b848879768359fd13650529961
>>          # save the attached .config to linux build tree
>>          GCC_VERSION=9.2.0 make.cross ARCH=sh
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     sh4-linux-objcopy: Unable to change endianness of input file(s)
>>>> sh4-linux-ld: cannot find drivers/spi/.tmp_gl_spi-mux.o: No such
>>>> file or directory
>>>> sh4-linux-objcopy: 'drivers/spi/.tmp_mx_spi-mux.o': No such file
>>     rm: cannot remove 'drivers/spi/.tmp_gl_spi-mux.o': No such file or
>> directory
>>     rm: cannot remove 'drivers/spi/.tmp_mx_spi-mux.o': No such file or
>> directory
>> --
> I attempted to reproduce this. The sh4 toolchain was unhappy with my
> system (missing libisl.so.22). I bodged something together and got
> errors like this all over the place. I also tried the previous commit
> and still got the same errors.

Thanks for the feedback, we'll check again.

Best Regards,
Rong Chen

>
>>     sh4-linux-objcopy: Unable to change endianness of input file(s)
>>>> sh4-linux-ld: cannot find drivers/mux/.tmp_gl_core.o: No such
>>>> file or directory
>>>> sh4-linux-objcopy: 'drivers/mux/.tmp_mx_core.o': No such file
>>     rm: cannot remove 'drivers/mux/.tmp_gl_core.o': No such file or
>> directory
>>     rm: cannot remove 'drivers/mux/.tmp_mx_core.o': No such file or
>> directory
>> --
>>     sh4-linux-objcopy: Unable to change endianness of input file(s)
>>>> sh4-linux-ld: cannot find drivers/mux/.tmp_gl_adg792a.o: No such
>>>> file or directory
>>>> sh4-linux-objcopy: 'drivers/mux/.tmp_mx_adg792a.o': No such file
>>     rm: cannot remove 'drivers/mux/.tmp_gl_adg792a.o': No such file or
>> directory
>>     rm: cannot remove 'drivers/mux/.tmp_mx_adg792a.o': No such file or
>> directory
>> --
>>>> sh4-linux-ar: drivers/mux/core.o: No such file or directory
>> --
>>>> sh4-linux-ld: cannot find drivers/mux/adg792a.o: No such file or
>>>> directory
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

