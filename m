Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A779D2ABF32
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgKIOtW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbgKIOtV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:49:21 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4639C0613CF;
        Mon,  9 Nov 2020 06:49:21 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so6098684qtb.10;
        Mon, 09 Nov 2020 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l2UTPfjMOy4W/99qQHXOpF1Lpnf53K1hsAMO22jvIkY=;
        b=e694j70uTcmP3PIO7aPqHeFYsM6YllddqDAzZr1cXTDGdP5GV31JlqTiGFOGK7WwXJ
         yVZ2bkJ4fZkdLuj2ZcIfqRVTQrjvtriS+Cv+6CuOS8y4MfJtoPRFXdKe1lwjw3CiM/2x
         z+mkAv0KcHb391bjam54gdM2ODfWH6qVZisIQXTLuNB71Yz9ouCRIHCN3AGi5Unj97YU
         LKnusTZeQFNoDADrnNx5attcaYoj6GMheflr3Ml4io48C/Jn41V/falwIU+Dnq8L6n5R
         rMoa73GTwWypCkxL1QPG7PHsPRVjjcKb66vQ2hf9U3zmncgGH/6N/RgsE3BFmKRYUDo9
         p2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=l2UTPfjMOy4W/99qQHXOpF1Lpnf53K1hsAMO22jvIkY=;
        b=YFGPk+lqkG9OADW0w3hCckG/e+W1WdsS+yzjCzsbfw52bW4hIT0hkTNvGjLPDX1BYA
         yCxUvKFlf5D5tMpiyST39kStaMGS4tohm88LQHveyfjRTfo9kwXBxt0c597W3C4LZaTW
         r85hNhiEIxbqv4MxkAM/xYCJtdYZsBZap5othvHxGicUPx1OclzuUIKA4h34IdUA6Q5i
         4CuOG56zkRnvaAyZ0ojzBXPEoa7Hntp4G6w/ekche5KC2qjQMNb1//t6ZRzqSM0qtz7z
         MyhJc1dSJ2OUvp3tr5WbEa1HMEZPkVxw+O8ne987Hz1TrLH4jYxzPEnxud/Ps0QJg3G3
         d2+A==
X-Gm-Message-State: AOAM53377YEQlCXkOnIYyjMo3Zi0xxVuteeQMnsTe67U+i3S81Brk2Cg
        eWtxnuMDCw8UTssYPtDhaffvQ4BGLluA+w==
X-Google-Smtp-Source: ABdhPJwudeu3VY4+R4JvfKhFzFtuA6XAa0PXz5m/Acmue+Jt3OltUI7YziPpbKc1TVe9+di/2uPvlA==
X-Received: by 2002:ac8:3499:: with SMTP id w25mr13388711qtb.44.1604933360938;
        Mon, 09 Nov 2020 06:49:20 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id q20sm5956338qtn.80.2020.11.09.06.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:49:20 -0800 (PST)
Subject: Re: [PATCH 02/32] spi: dw: Add support for 32-bits ctrlr0 layout
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-3-damien.lemoal@wdc.com>
 <20201109142529.tt5ojjyn36vd3ohe@mobilestation>
 <6dc6d52e-a39d-c351-5280-71b9e8eafe37@gmail.com>
 <CAHp75VejtoTRAM1JmGib3OaJwzuw9Bb-qb08+XhdZUOuzTGUKw@mail.gmail.com>
 <CAHp75Vc+h5PCqBUnyFshw8RE4zWusE+zdvKKSxBxfFw1_5k0vQ@mail.gmail.com>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <7e8bba71-763e-2e09-88d2-d736a56a6920@gmail.com>
Date:   Mon, 9 Nov 2020 09:49:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc+h5PCqBUnyFshw8RE4zWusE+zdvKKSxBxfFw1_5k0vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/9/20 9:41 AM, Andy Shevchenko wrote:
> On Mon, Nov 9, 2020 at 4:40 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Mon, Nov 9, 2020 at 4:34 PM Sean Anderson <seanga2@gmail.com> wrote:
>>> On 11/9/20 9:25 AM, Serge Semin wrote:
>>>> On Sat, Nov 07, 2020 at 05:13:50PM +0900, Damien Le Moal wrote:
>>
>> ...
>>
>>>> Are you sure they have been moved from [0, 3] to [16, 20]? I don't have the
>>>> manual for the 4.0x version of the core, but according to this patch:
>>>> https://patchwork.kernel.org/project/spi-devel-general/patch/1575907443-26377-7-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com/
>>>> it has been ok to use the lowest four bits for DFS setting. Is the commit
>>>> message misleading there?
>>>
>>> This commit message is a truncated version of [1].
>>
>> I don't see how they are related.

I think this commit message is specifically taken from v3 of that patch
[2]. However, I had not gotten a chance to have a look at the datasheet
at that point, so it is a bit misleading (e.g. showing dfs for devices
with SSI_MAX_XFER_SIZE=32, even though it is all zeros for those
devices). In any case, the diagram is taken from that patch.

[2] https://patchwork.ozlabs.org/project/uboot/patch/20200914153503.91983-7-seanga2@gmail.com/

> 
> For DW_ssi v1.x DFS is always for transfers up to 32-bit.

Do you mean DWC_ssi?

> 
>>> Importantly, DFS is
>>> valid when SSI_MAX_XFER_SIZE=16. When it =32, then DFS_32 must be used
>>> (since DFS is constant 0xF). Since SSI_MAX_XFER_SIZE is a synthesis
>>> parameter, there exist devices where DFS must be used, and also where
>>> DFS_32 must be used.
>>>
>>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20201016225755.302659-10-seanga2@gmail.com/
> 
> 
> 

