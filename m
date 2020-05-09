Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E571CBFA2
	for <lists+linux-spi@lfdr.de>; Sat,  9 May 2020 11:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgEIJLI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 9 May 2020 05:11:08 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:54252 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgEIJLI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 9 May 2020 05:11:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 5872F2003CA0;
        Sat,  9 May 2020 17:11:06 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id odAZhTF_7maC; Sat,  9 May 2020 17:11:06 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 3627320020CB;
        Sat,  9 May 2020 17:11:06 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.244])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 72D14C019F4;
        Sat,  9 May 2020 17:11:05 +0800 (HKT)
Subject: Re: [PATCH v0 1/1] spi: spi-rockchip: add support for spi slave_mode
To:     Emil Renner Berthing <emil.renner.berthing@gmail.com>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20200508083729.5560-1-chris.ruehl@gtsys.com.hk>
 <20200508083729.5560-2-chris.ruehl@gtsys.com.hk>
 <CANBLGcwA+=OB-_nOYUijWrDBSkLYhR7_PNG1ewO7LZ-zRVGoxg@mail.gmail.com>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <fdd18c31-f97c-e31f-8056-f4affbdb519b@gtsys.com.hk>
Date:   Sat, 9 May 2020 17:11:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANBLGcwA+=OB-_nOYUijWrDBSkLYhR7_PNG1ewO7LZ-zRVGoxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Emil,


>> +       if (rs->slavemode)

here is a mistake  it is :  rs->slave_mode
and the use of rs->slave_mode in the rockchip_spi_config()
