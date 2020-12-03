Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B62CCDFB
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 05:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgLCEkJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 23:40:09 -0500
Received: from smtp33.i.mail.ru ([94.100.177.93]:51494 "EHLO smtp33.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbgLCEkI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Dec 2020 23:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=QvBzXi8qwcgCy4r2tg9JsYzcMug0+tOAx69fgU6vtLI=;
        b=UUWJyFSBjxQjulnkPBz5J0tZVgEJw6Cn55fcyBq+wyKOpvtoSbCjdDUSSZE7XD9ZPBrfZytJ63fYSTR673862ZWciJU3YV2nETH6yYhXwpg4tM9RCHFW9BQiH3mPkH/m3x3Y8Pru7FH20/602HGxdqSXug64hqekSs4zdsg2Ri0=;
Received: by smtp33.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1kkgOm-00087b-ER; Thu, 03 Dec 2020 07:39:20 +0300
Subject: Re: [PATCH] spi: spi-fsl-dspi: Use max_native_cs instead of
 num_chipselect to set SPI_MCR
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org
References: <20201202142552.44385-1-fido_max@inbox.ru>
 <20201202235728.jihjacbuo2362f6v@skbuf>
From:   Maxim Kochetkov <fido_max@inbox.ru>
Message-ID: <f0fa00dc-292b-382d-7513-892b5a497759@inbox.ru>
Date:   Thu, 3 Dec 2020 07:40:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202235728.jihjacbuo2362f6v@skbuf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp33.i.mail.ru; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD913934B9F4F77822879238875636E12E80216BDF6A1F8E85C00894C459B0CD1B9914EA9B8EE230D1403F84FF3DE0059214E61F2C6E0D3C2FD31DEC98D3E96EC86
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7E9C30BC00893CB9AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637EEA194BB48C104EF8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC2E9C86658F9FA5FE026B5D34646F77B93AFB9CE77B5CF27B389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0A3E989B1926288338941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C34964A708C60C975A117882F4460429728AD0CFFFB425014E1D3B0F1236BFD7A076E601842F6C81A19E625A9149C048EE7B96B19DC40933211133410A2FE6C23AD8FC6C240DEA76429449624AB7ADAF37B2D370F7B14D4BC40A6AB1C7CE11FEE3C824672CB62AFFF29735652A29929C6CC4224003CC8364768BB5CB66B4D4C327A7F4EDE966BC389F9E8FC8737B5C22497A1503C2FF388B9B089D37D7C0E48F6CCF19DD082D7633A0E7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7C46FB19369A11121443847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148FA8EF81845B15A4842623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5BF51C7170A01D844F38BC33CEFF363F782CE54B1941735D1D59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA75363A6695AA4CE4EF410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC444B13AA3CD6011C2E7B58BE4DC98E85AEFC8D8A905522F76A1C42CD26C19EC2A01248E331D56036872CF105D688DC0BF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj8a0f6CGnvE5hckXJJIjmpw==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB24FB4D22226A7E8427D3C85F71B5F38861756B73AC4C353EEBEE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I'm sorry for that.
I checked at https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ 
before resend and didn't find any updates.

03.12.2020 02:57, Vladimir Oltean пишет:
> On Wed, Dec 02, 2020 at 05:25:52PM +0300, Maxim Kochetkov wrote:
>> If cs-gpios property is used in devicetree then ctlr->num_chipselect value
>> may be changed by spi_get_gpio_descs().
>> So use ctlr->max_native_cs instead of ctlr->num_chipselect to set SPI_MCR
>>
>> Fixes: 4fcc7c2292de (spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR)
>> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
>> ---
> 
> In this case, it looks like Mark did really apply it, Maxim, I'm not
> sure why you resent:
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-5.10&id=2c2b3ad2c4c801bab1eec7264ea6991b1e4e8f2c
> 
