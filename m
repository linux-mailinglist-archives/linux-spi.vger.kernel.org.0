Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6315B2CBF6F
	for <lists+linux-spi@lfdr.de>; Wed,  2 Dec 2020 15:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgLBOTy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Dec 2020 09:19:54 -0500
Received: from smtp32.i.mail.ru ([94.100.177.92]:55610 "EHLO smtp32.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgLBOTx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Dec 2020 09:19:53 -0500
X-Greylist: delayed 105624 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 09:19:52 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=1KubNwOij4FPsfnzVTuQ2tyRHNOBjlhSnI5+ptlFsHs=;
        b=SWX0MqO2cz1XTM3a38uj5LS3MkTwyCdr4ZbTazTI3sRI6MYivdpM6FWAAW35uy2eGW8kf0yP9IV8kSQQMN7V11Yi8Eq5NYfv8iXO/c//QwC0+1/P+W1J4rXupEj4mEEgfR+4gfpKRuWlp7vKYgUoLvYHbIaBbfagtNqDozh2flk=;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1kkSyH-0005vq-9d; Wed, 02 Dec 2020 17:19:05 +0300
Subject: Re: [PATCH] spi: spi-fsl-dspi: Use max_native_cs instead of
 num_chipselect to set SPI_MCR
To:     Mark Brown <broonie@kernel.org>
Cc:     olteanv@gmail.com, linux-spi@vger.kernel.org
References: <20201201085916.63543-1-fido_max@inbox.ru>
 <160683107678.35139.1439064414776102118.b4-ty@kernel.org>
From:   Maxim Kochetkov <fido_max@inbox.ru>
Message-ID: <e19002f8-a8a8-6201-6680-ef0b586c6367@inbox.ru>
Date:   Wed, 2 Dec 2020 17:20:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <160683107678.35139.1439064414776102118.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp32.i.mail.ru; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD913934B9F4F7782280D93F21DA0904FC28AB459B2474A1A0400894C459B0CD1B95ED4E3B6E68C129B5BB2915B42D1860781010C32BCB4F07FBE26E60622977F24
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78E8764B5BC580342EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006379BF04B24BEB7B2D58638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FCE63C2A44C22B1458DD5B09FD2EBEBB85A1EA902E93A91F7C389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0ECC8AC47CD0EDEFF8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C3329DC2EF12373DEA117882F4460429728AD0CFFFB425014E1D3B0F1236BFD7A076E601842F6C81A19E625A9149C048EED76C6ED7039589DEC5236E9430F51F07D8FC6C240DEA76429449624AB7ADAF37B2D370F7B14D4BC40A6AB1C7CE11FEE370E94058F73C6C689735652A29929C6CC4224003CC836476EA7A3FFF5B025636A7F4EDE966BC389F9E8FC8737B5C22490DA844A29351D9B7089D37D7C0E48F6CCF19DD082D7633A0E7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7C455ECF6163D76FB543847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148FA8EF81845B15A4842623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A569CF59D28748B0BC378AC788E67E1A2ECC68057809AFB097D59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA7538889A5EF59567618E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC4168E0537720246A0E7B58BE4DC98E85AB81AE3DCF1C758A3E2B53497D057A4B3036B0D1E39C4872772CF105D688DC0BF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj8a0f6CGnvE68Z8CeNNMdSg==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB245EEDBC6857656696606B5E2C20383039E648D228684D36CBEE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Should I resend it?

01.12.2020 16:57, Mark Brown пишет:
> On Tue, 1 Dec 2020 11:59:16 +0300, Maxim Kochetkov wrote:
>> If cs-gpios property is used in devicetree then ctlr->num_chipselect value
>> may be changed by spi_get_gpio_descs().
>> So use ctlr->max_native_cs instead of ctlr->num_chipselect to set SPI_MCR
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] spi: spi-fsl-dspi: Use max_native_cs instead of num_chipselect to set SPI_MCR
>        (no commit info)
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
